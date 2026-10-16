import {
  startOfYear,
  endOfYear,
  sub,
  startOfMonth,
  endOfMonth,
  startOfDay,
  endOfDay,
} from "date-fns";
import type { TransactionView, TransactionPeriod } from "~/types";

export const useSelectedTimePeriod = (period: Ref<TransactionView>) => {
  const current = computed<TransactionPeriod>(() => {
    switch (period.value) {
      case "Yearly":
        return {
          from: startOfYear(new Date()),
          to: new Date(),
        };
      case "Daily":
        return {
          from: startOfDay(new Date()),
          to: new Date(),
        };
      case "Monthly":
        return {
          from: startOfMonth(new Date()),
          to: new Date(),
        };
         default:
      throw new Error(`Unknown transaction view: ${period.value}`);
    }
  });
  const previous = computed(() => {
    switch (period.value) {
      case "Yearly":
        return {
          from: startOfYear(sub(new Date(), { years: 1 })),
          to: endOfYear(sub(new Date(), { years: 1 })),
        };
      case "Daily":
        return {
          from: startOfDay(sub(new Date(), { days: 1 })),
          to: endOfDay(sub(new Date(), { days: 1 })),
        };
      case "Monthly":
        return {
          from: startOfYear(sub(new Date(), { months: 1 })),
          to: endOfMonth(sub(new Date(), { months: 1 })),
        };
         default:
      throw new Error(`Unknown transaction view: ${period.value}`);
    }
  });
  return { current, previous };
};
