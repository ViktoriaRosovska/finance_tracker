export const useCurrency = (amount: MaybeRef<number>) => {
  const currency = computed(() => {
    return Intl.NumberFormat("en-IN", {
      style: "currency",
      currency: "USD",
    }).format(unref(amount));
  });
  return { currency };
};
