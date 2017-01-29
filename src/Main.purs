
module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import DOM (DOM)
import Signal (Signal, runSignal, merge, sampleOn, filter, (~>))
import Nozzle.Signal (pumpFuel, totalPrice)
import KeyPad.Signal (setPreset)
import Liter.Signal (fuelFlow)


main :: forall eff. Eff (dom :: DOM | eff) Unit
main = do
  signalFuel1 <- pumpFuel "nozzle1" "price1" 1.23
  signalFuel2 <- pumpFuel "nozzle2" "price2" 1.37
  signalFuel3 <- pumpFuel "nozzle3" "price3" 1.65
  signalDollars1 <- totalPrice "price1" 1.23
  signalDollars2 <- totalPrice "price2" 1.37
  signalDollars3 <- totalPrice "price3" 1.65
  let signalFuel = signalFuel1 `merge` signalFuel2 `merge` signalFuel3
      signalDollars = signalDollars1 `merge` signalDollars2 `merge` signalDollars3
  signalPreset <- setPreset
  flow <- fuelFlow 0.157
  runSignal $ signalFuel `merge` signalDollars `merge` signalPreset `merge` flow
