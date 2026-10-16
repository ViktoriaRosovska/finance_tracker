import { z } from "zod";
import { transactionViewOptions } from "~/constants";
export const schemaSettings = z.object({
  transactionView: z.enum(transactionViewOptions),
});
