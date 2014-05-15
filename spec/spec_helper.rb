require 'rubygems'
require 'rspec'
require 'rspec/core/shared_context'

$LOAD_PATH.unshift File.expand_path('../../lib')
require 'irc_crawler'
include IrcCrawler

