export const useCurrency = (amount: MaybeRef<number>) => {
  const currency = computed(() => {
    return Intl.NumberFormat("en-IN", {
      style: "currency",
      currency: "USD",
    }).format(isRef(amount)? amount.value : amount);
  });
  return { currency };
};
