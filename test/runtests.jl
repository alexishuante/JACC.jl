import JACC

using Pkg

const backend = JACC.JACCPreferences.backend

@static if backend == "cuda"
    # Pkg.add(; name = "CUDA", version = "v5.1.1")
    Pkg.add("CUDA")
    println("CUDA backend loaded")
    using CUDA

elseif backend == "amdgpu"
    Pkg.add(; name = "AMDGPU", version = "v0.8.6")
    # Pkg.add("AMDGPU")
    println("AMDGPU backend loaded")
    using AMDGPU

elseif backend == "oneapi"
    Pkg.add("oneAPI")
    println("oneAPI backend loaded")
    using oneAPI

elseif backend == "threads"
    println("Threads backend loaded")
end

backends = [Symbol(x) for x in JACC.JACCPreferences.supported_backends]
exclude = setdiff(backends, [Symbol(backend)])

using TestItemRunner
if isempty(ARGS)
    @run_package_tests filter = ti -> isempty(intersect(exclude, ti.tags))
else
    tagstrs = filter(arg -> startswith(arg, "@"), ARGS)
    tags = map(t -> Symbol(t[2:end]), tagstrs)
    function tag_match(ti)
        !isempty(intersect(tags, ti.tags))
    end

    names = map(lowercase, setdiff(ARGS, tagstrs))
    function name_match(ti)
        findfirst(n -> contains(lowercase(ti.name), n), names) != nothing
    end

    @run_package_tests verbose = true filter = ti -> (tag_match(ti) || name_match(ti))
end
