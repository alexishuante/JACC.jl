module JACCPreferences
using Preferences
const supported_backends = ("threads", "cuda", "amdgpu", "oneapi")

function set_backend(new_backend::String)
    new_backend_lc = lowercase(new_backend)
    if !(new_backend_lc in supported_backends)
        throw(ArgumentError("Invalid backend: \"$(new_backend)\""))
    end
    @set_preferences!("backend"=>new_backend_lc)
    @info("New backend set; restart your Julia session for this change to take effect!")
end

const backend = @load_preference("backend", "threads")
const _backend_dispatchable = Val{Symbol(backend)}()
end # module JACCPreferences

@show JACCPreferences.backend
