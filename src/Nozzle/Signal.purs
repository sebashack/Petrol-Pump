module Nozzle.Signal (pumpFuel, totalPrice) where

import Prelude (Unit, bind, ($), pure, unit)
import Control.Monad.Eff (Eff)
import DOM (DOM)
import Signal (Signal, constant, merge, (~>))
import Signal.Time (every)


foreign import signalNozzle :: forall eff c.
                               String
                            -> String
                            -> (c -> Signal c)
                            -> Eff (dom :: DOM | eff) (Signal Number)

foreign import displayPrice :: forall eff c.
                                String
                             -> Number
                             -> Eff (dom :: DOM | eff) Unit

foreign import displayTotal :: forall eff c.
                               String
                            -> Number
                            -> Eff (dom :: DOM | eff) Unit


signalRate :: Number -> Signal Number
signalRate rate = every 1000.0 ~> (\t -> rate)

pumpFuel :: forall eff.
            String
         -> String
         -> Number
         -> Eff (dom :: DOM | eff)
                (Signal (Eff (dom :: DOM | eff) Unit))
pumpFuel nozzle price rate = do
  signal1 <- signalNozzle nozzle price constant
  let signal2 = signal1 `merge` signalRate rate
  pure $ signal2  ~> displayPrice price


totalPrice :: forall eff.
              String
           -> Number
           -> Eff (dom :: DOM | eff)
                  (Signal (Eff (dom :: DOM | eff) Unit))
totalPrice price rate = do
  let signal = signalRate rate ~> displayTotal price
  pure $ signal
