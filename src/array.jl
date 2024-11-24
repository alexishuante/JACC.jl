
# function zeros(::ThreadsBackend, T, dims...)
#     return Base.zeros(T, dims...)
# end

# function ones(::ThreadsBackend, T, dims...)
#     return Base.ones(T, dims...)
# end

# zeros(T, dims...) = zeros(default_backend(), T, dims...)

# ones(T, dims...) = ones(default_backend(), T, dims...)


# Direct array operations without backend dispatch
function zeros(T, dims...)
    return Base.zeros(T, dims...)
end

function ones(T, dims...)
    return Base.ones(T, dims...)
end

# Keep these for compatibility but make them direct
function zeros(::ThreadsBackend, T, dims...)
    return Base.zeros(T, dims...)
end

function ones(::ThreadsBackend, T, dims...)
    return Base.ones(T, dims...)
end
