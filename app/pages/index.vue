<template>
  <section class="flex items-center justify-between mb-10">
    <h1 class="text-4xl font-extrabold">Sumary</h1>
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
      :amount="incomeTotal"
      :last-amount="3000"
      :loading="pending"
    />
    <Trend
      title="Expence"
      :amount="expenseTotal"
      :last-amount="6000"
      :loading="pending"
    />
    <Trend
      title="Investments"
      :amount="4000"
      :last-amount="3000"
      :loading="pending"
    />
    <Trend
      title="Saving"
      :amount="4000"
      :last-amount="5000"
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
      <TransactionModal />
    </div>
  </section>
  <section v-if="!pending">
    <ul>
      <li
        v-for="(transactionOnDay, date) in transactionsGroupedByDate"
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
                @deleted="refreshTransactions"
              />
            </li>
          </ul>
        </div>
      </li>
    </ul>
  </section>
  <section v-else>
    <USkeleton class="h-8 w-full mb-2" v-for="i in 4" :key="i" />
  </section>
</template>
<script setup lang="ts">
import { transactionViewOptions } from "~/constants";
import type { Transaction } from "~/types";

const supabase = useSupabaseClient();

const fetchTransactions = async () => {
  const { data, error } = await supabase.from("transactions").select(`
    id,
    amount,
    type,
    description,
    transaction_date,
    created_at,
    category:categories (
      name
    )
  `);
  if (error) {
    return [];
  }
  return data ?? [];
};

const {
  data: transactions,
  pending,
  //refresh,
  //error,
} = await useAsyncData<Transaction[]>("transactions", fetchTransactions, {
  default: () => [],
});

const refreshTransactions = async () => {
  transactions.value = await fetchTransactions();
};

await refreshTransactions();

const transactionsGroupedByDate = computed(() => {
  let grouped: Record<string, Transaction[]> = {};
  for (const transaction of transactions.value) {
    const date = transaction.transaction_date.slice(0, 10);
    if (!grouped[date]) {
      grouped[date] = [];
    }
    grouped[date].push(transaction);
  }
  return grouped;
});

//console.log(transactionsGroupedByDate.value);

// const totals = computed(() => {
//   return transactions.value.reduce(
//     (result, transaction) => {
//       result[transaction.type] =
//         (result[transaction.type] ?? 0) + transaction.amount;
//       return result;
//     },
//     {} as Record<string, number>,
//   );
// });

const income = computed(() =>
  transactions.value.filter((t) => t.type === "income"),
);
const expense = computed(() =>
  transactions.value.filter((t) => t.type === "expense"),
);
const incomeCount = computed(() => income.value.length);
const expenseCount = computed(() => expense.value.length);

const incomeTotal = computed(() =>
  income.value.reduce((sum, transaction) => sum + transaction.amount, 0),
);
const expenseTotal = computed(() =>
  expense.value.reduce((sum, transaction) => sum + transaction.amount, 0),
);
const selectedView = ref<string>(transactionViewOptions[1] ?? "Monthly");
</script>
