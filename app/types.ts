import { transactionViewOptions } from "./constants";

export interface GetTransaction {
  id: string;
  amount: number;
  type: string;
  description: string | null;
  transaction_date: string;
  created_at: string;
  category: { name: string } | null;
}

export interface AddTransactionForm {
  type: "income" | "expense" | undefined;
  amount: number | undefined;
  description: string | undefined;
  created_at: string | undefined;
  transaction_date: string;
  category_id: string | undefined;
}

export type TransactionView = (typeof transactionViewOptions)[number];

export interface TransactionPeriod {
  from: Date;
  to: Date;
}

export interface UpdateUser {
  email?: string;
  password?: string;
  data?: {
    name?: string;
    [key: string]: string | undefined | null;
  };
}
