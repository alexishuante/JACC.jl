
# function zeros(::ThreadsBackend, T, dims...)
#     return Base.zeros(T, dims...)
# end

# function ones(::ThreadsBackend, T, dims...)
#     return Base.ones(T, dims...)
# end

# zeros(T, dims...) = zeros(default_backend(), T, dims...)

# ones(T, dims...) = ones(default_backend(), T, dims...)


# Fast path implementations for array operations
function zeros(T, dims...)
    if default_backend() isa ThreadsBackend
        return Base.zeros(T, dims...)
    else
        return zeros(default_backend(), T, dims...)
    end
end

function ones(T, dims...)
    if default_backend() isa ThreadsBackend
        return Base.ones(T, dims...)
    else
        return ones(default_backend(), T, dims...)
    end
end

# Backend-specific implementations
function zeros(::ThreadsBackend, T, dims...)
    return Base.zeros(T, dims...)
end

function ones(::ThreadsBackend, T, dims...)
    return Base.ones(T, dims...)
end

# These will be overridden by GPU backends
function zeros(backend::Any, T, dims...)
    return Base.zeros(T, dims...)
end

function ones(backend::Any, T, dims...)
    return Base.ones(T, dims...)
end
