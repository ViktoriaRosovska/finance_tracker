import { z } from "zod";

export const schemaAddTransaction = z.object({
  user_id: z.string(),
  type: z.literal(["income", "expense"], "Choose transaction's type"),
  amount: z.number("Enter amount").positive("Amount needs to be more than 0"),
  description: z.string().trim().optional(),
  created_at: z.string(),
  transaction_date: z.string().trim(),
  category_id: z.string("Select category"),
});

export type SchemaAddTransaction = z.output<typeof schemaAddTransaction>;
