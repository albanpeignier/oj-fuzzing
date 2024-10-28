#!/usr/bin/env ruby

# frozen_string_literal: true

require 'ruzzy'
require 'oj'

test_one_input = lambda do |data|
  begin
    Oj.load(data)
  rescue Oj::ParseError, EncodingError, ArgumentError
    # pass
  end
  return 0
end

Ruzzy.fuzz(test_one_input)
