import { z } from "zod";

export const schemaUpdateUser = z.object({
  name: z
    .string()
    .transform((value) => value.trim())
    .refine(
      (value) => value === "" || value.length >= 2,
      "Name must be at least 2 characters",
    ),
  email: z.email("Enter correct email"),
  password: z.string().optional(),
});

export type SchemaUpdateUser = z.output<typeof schemaUpdateUser>;
