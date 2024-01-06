# frozen_string_literal: true

require_relative "deep_compactor/version"

# For deep compact nested Array and Hash.
module DeepCompactor
  refine Array do
    def deep_compact
      map do |value|
        if value.is_a?(Array) || value.is_a?(Hash)
          value.deep_compact
        else
          value
        end
      end.compact
    end

    def deep_compact!
      map! do |value|
        if value.is_a?(Array) || value.is_a?(Hash)
          value.deep_compact
        else
          value
        end
      end.compact!
    end

    def deep_compact_blank
      map do |value|
        if value.is_a?(Array) || value.is_a?(Hash)
          value.empty? ? nil : value.deep_compact_blank
        else
          value
        end
      end.compact
    end
  end

  refine Hash do
    def deep_compact
      to_h do |key, value|
        if value.is_a?(Array) || value.is_a?(Hash)
          [key, value.deep_compact]
        else
          [key, value]
        end
      end.compact
    end

    def deep_compact_blank
      to_h do |key, value|
        if value.is_a?(Array) || value.is_a?(Hash)
          value.empty? ? [key, nil] : [key, value.deep_compact_blank]
        else
          [key, value]
        end
      end.compact
    end
  end
end
