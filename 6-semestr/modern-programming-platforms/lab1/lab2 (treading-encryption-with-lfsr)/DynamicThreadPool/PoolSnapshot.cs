namespace DynamicThreadPoolModule;

public sealed record PoolSnapshot(
    int MinWorkers,
    int MaxWorkers,
    int TotalWorkers,
    int BusyWorkers,
    int IdleWorkers,
    int QueuedItems
);