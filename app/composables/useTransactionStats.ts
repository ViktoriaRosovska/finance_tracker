import type { GetTransaction } from "~/types";

export const useTransactionStats = (transactions: Ref<GetTransaction[]>) => {
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
  return {
    income,
    expense,
    incomeCount,
    expenseCount,
    incomeTotal,
    expenseTotal,
  };
};
