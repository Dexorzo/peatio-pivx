require "active_support/core_ext/object/blank"
require "active_support/core_ext/enumerable"
require "peatio"

module Peatio
  module Pivx
    require "bigdecimal"
    require "bigdecimal/util"

    require "peatio/pivx/blockchain"
    require "peatio/pivx/client"
    require "peatio/pivx/wallet"

    require "peatio/pivx/hooks"

    require "peatio/pivx/version"
  end
end
