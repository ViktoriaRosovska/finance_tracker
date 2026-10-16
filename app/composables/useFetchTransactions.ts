import type { GetTransaction, TransactionPeriod } from "~/types";
import type { Database } from "~/database.types";

export const useFetchTransactions = () => {
  const supabase = useSupabaseClient<Database>();

  const getTransactions = async (): Promise<GetTransaction[]> => {
    const { data, error } = await supabase
      .from("transactions")
      .select(
        `
    id,
    amount,
    type,
    description,
    transaction_date,
    created_at,
    category:categories (
      name
    )
  `,
      )
      .order("transaction_date", { ascending: false });
    if (error) {
      throw error;
    }
    return data ?? [];
  };

  const getTransactionsByPeriod = async (
    period: TransactionPeriod,
  ): Promise<GetTransaction[]> => {
    const { data, error } = await supabase
      .from("transactions")
      .select(
        `
    id,
    amount,
    type,
    description,
    transaction_date,
    created_at,
    category:categories (
      name
    )
  `,
      )
      .gte("transaction_date", period.from.toISOString())
      .lte("transaction_date", period.to.toISOString())
      .order("transaction_date", { ascending: false });
    if (error) {
      throw error;
    }

    return data ?? [];
  };
  const addTransaction = async (
    transaction: Database["public"]["Tables"]["transactions"]["Insert"],
  ) => {
    const { error } = await supabase.from("transactions").insert(transaction);

    if (error) {
      throw error;
    }
  };
  const editTransaction = async (
    id: string,
    transaction: Database["public"]["Tables"]["transactions"]["Update"],
  ) => {
    const { error } = await supabase
      .from("transactions")
      .update(transaction)
      .eq("id", id);

    if (error) {
      throw error;
    }
  };

  const {
    data: transactions,
    pending,
    refresh,
  } = useAsyncData<GetTransaction[]>("transactions", getTransactions, {
    default: () => [],
  });

  return {
    getTransactions,
    getTransactionsByPeriod,
    addTransaction,
    editTransaction,
    refresh,
    transactions,
    pending,
  };
};
