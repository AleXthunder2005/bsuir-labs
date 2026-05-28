namespace DynamicThreadPoolModule;

public sealed class PoolHandle<T>
{
    private readonly TaskCompletionSource<T> _tcs =
        new(TaskCreationOptions.RunContinuationsAsynchronously);

    public string Name { get; }

    internal PoolHandle(string name)
    {
        Name = name;
    }

    public Task<T> Completion => _tcs.Task;

    internal void SetResult(T value) => _tcs.TrySetResult(value);
    internal void SetException(Exception ex) => _tcs.TrySetException(ex);
}
