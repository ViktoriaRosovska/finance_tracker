export const useAppToast = () => {
  const toast = useToast();

  return {
    toastSuccess: ({
      title,
      description,
    }: {
      title: string;
      description?: string;
    }) => {
      toast.add({
        title,
        description,
        icon: "i-heroicons-check-circle",
        color: "success",
      });
    },
    toastError: ({
      title,
      description = "Unknown error",
    }: {
      title: string;
      description?: string;
    }) => {
      toast.add({
        title,
        description,
        icon: "i-heroicons-exclamation-circle",
        color: "error",
      });
    },
    toastInfo: ({
      title,
      description,
    }: {
      title: string;
      description?: string;
    }) => {
      toast.add({
        title,
        description,
        icon: "i-heroicons-shield-exclamation",
        color: "info",
      });
    },
  };
};
