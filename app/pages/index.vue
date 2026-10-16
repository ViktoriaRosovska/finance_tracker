<template>
  <section class="flex items-center justify-between mb-10">
    <h1 class="text-4xl font-extrabold">Summary</h1>
    <div>
      <USelectMenu
        :items="transactionViewOptions"
        v-model="selectedView"
        class="w-28"
        :search-input="false"
      />
    </div>
  </section>
  <section
    class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 sm:gap-16 mb-10"
  >
    <Trend
      title="Income"
      :amount="totalIncomeCurrent"
      :last-amount="totalIncomePrevious"
      :loading="pending"
    />
    <Trend
      title="Expense"
      :amount="totalExpenseCurrent"
      :last-amount="totalExpensePrevious"
      :loading="pending"
    />
  </section>
  <section class="flex justify-between mb-10">
    <div>
      <h2 class="text-2xl font-extrabold">Transactions</h2>
      <div class="text-gray-500 dark:text-gray-400">
        You have {{ incomeCount }} incomes and {{ expenseCount }} expenses this
        period
      </div>
    </div>
    <div>
      <UButton
        icon="i-heroicons-plus-circle"
        color="primary"
        variant="solid"
        label="Add"
        @click="openForCreate"
      />
      <TransactionModal
        @saved-transaction="refresh"
        :transaction="currentTransaction"
        v-model:open="isTransactionModalOpen"
      />
    </div>
  </section>
  <section>
    <div v-if="!transactions.length && pending">
      <USkeleton v-for="i in 4" :key="i" class="h-8 w-full mb-2" />
    </div>
    <p v-else-if="transactions.length === 0">No transactions yet...</p>

    <ul v-else>
      <li
        v-for="(transactionOnDay, date) in transactionsGrouped"
        :key="date"
        class="mb-10"
      >
        <div>
          <DailyTransactionSummary
            :date="date"
            :transactions="transactionOnDay"
          />

          <ul>
            <li v-for="transaction in transactionOnDay" :key="transaction.id">
              <Transaction
                :transaction="transaction"
                @deleted="refresh"
                @edited="openForEdit"
              />
            </li>
          </ul>
        </div>
      </li>
    </ul>
  </section>
</template>
<script setup lang="ts">
import { useSelectedTimePeriod } from "~/composables/useSelectedTimePeriod";
import { transactionViewOptions } from "~/constants";
import type { GetTransaction, TransactionView } from "~/types";
const { user } = useAuth();
const selectedView = ref<TransactionView>(
  user.value?.user_metadata?.transaction_view ?? transactionViewOptions[0],
);

const { current, previous } = useSelectedTimePeriod(selectedView);

const { transactions, refresh, pending, getTransactionsByPeriod } =
  useFetchTransactions();
await refresh();

let transactionsByPeriod: Ref<GetTransaction[]> = ref([]);
const totalIncomePrevious = ref(0);
const totalExpensePrevious = ref(0);
const totalIncomeCurrent = ref(0);
const totalExpenseCurrent = ref(0);
const previousPending = ref(false);

watch(
  selectedView,
  async () => {
    previousPending.value = true;

    try {
      const result = ref(await getTransactionsByPeriod(previous.value));
      const currentPeriod = ref(await getTransactionsByPeriod(current.value));
      const stats = useTransactionStats(result);

      const currentStats = useTransactionStats(currentPeriod);

      totalIncomePrevious.value = stats.incomeTotal.value;
      totalExpensePrevious.value = stats.expenseTotal.value;

      totalIncomeCurrent.value = currentStats.incomeTotal.value;
      totalExpenseCurrent.value = currentStats.expenseTotal.value;

      transactionsByPeriod.value = result.value;
    } finally {
      previousPending.value = false;
    }
  },
  { immediate: true },
);

const { incomeCount, expenseCount } = useTransactionStats(transactions);

const transactionsGroupedByDate = computed(() => {
  let grouped: Record<string, GetTransaction[]> = {};
  for (const transaction of transactions.value) {
    const date = transaction.transaction_date.slice(0, 10);
    if (!grouped[date]) {
      grouped[date] = [];
    }
    grouped[date].push(transaction);
  }

  return grouped;
});

const transactionsGroupedByMonth = computed(() => {
  let grouped: Record<string, GetTransaction[]> = {};
  for (const transaction of transactions.value) {
    const month = new Date(transaction.transaction_date).toLocaleString("en", {
      month: "long",
      year: "numeric",
    });
    if (!grouped[month]) {
      grouped[month] = [];
    }
    grouped[month].push(transaction);
  }

  return grouped;
});

const transactionsGroupedByYear = computed(() => {
  let grouped: Record<string, GetTransaction[]> = {};
  for (const transaction of transactions.value) {
    const year = transaction.transaction_date.slice(0, 4);
    if (!grouped[year]) {
      grouped[year] = [];
    }
    grouped[year].push(transaction);
  }

  return grouped;
});
const transactionsGrouped = computed(() => {
  switch (selectedView.value) {
    case "Yearly":
      return transactionsGroupedByYear.value;

    case "Monthly":
      return transactionsGroupedByMonth.value;

    default:
      return transactionsGroupedByDate.value;
  }
});

const currentTransaction = ref<GetTransaction | null>(null);

const isTransactionModalOpen = ref(false);
const openForCreate = () => {
  currentTransaction.value = null;
  isTransactionModalOpen.value = true;
};

const openForEdit = (transaction: GetTransaction) => {
  currentTransaction.value = transaction;
  isTransactionModalOpen.value = true;
  console.log(currentTransaction.value);
};

const config = useRuntimeConfig();

console.log(config.public.baseUrl);
</script>
