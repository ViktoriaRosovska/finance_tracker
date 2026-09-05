export interface Transaction {
  id: string;
  amount: number;
  type: string;
  description: string;
  transaction_date: string;
  created_at: string;
  category: {
    name: string;
  } | null;
}
