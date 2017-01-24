module Nozzle.Signal (pumpFuel) where

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

pumpFuel :: forall eff.
            String
         -> String
         -> Number
         -> Eff (dom :: DOM | eff)
                (Signal (Eff (dom :: DOM | eff) Unit))
pumpFuel nozzle price rate = do
  signal1 <- signalNozzle nozzle price constant
  let signal2 = signal1 `merge` (every 250.0 ~> (\t -> rate))
  pure $ signal2  ~> displayPrice price
