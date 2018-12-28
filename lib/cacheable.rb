# frozen_string_literal: true

module Cacheable
  def cache(func_name)
    alias_method "_#{func_name}_uncached".to_sym, func_name

    define_method(func_name) do |*args|
      cache_key = "#{func_name}:#{args}"
      cache_result = Redis.current.get(cache_key)
      return cache_result unless cache_result.nil?

      uncache_result = send("_#{func_name}_uncached", *args)

      Redis.current.set(cache_key, uncache_result)
      uncache_result
    end
  end
end
