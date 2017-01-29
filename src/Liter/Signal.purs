module Liter.Signal (fuelFlow) where

import Prelude (Unit, bind, ($), pure, unit)
import Control.Monad.Eff (Eff)
import DOM (DOM)
import Signal (Signal, constant, merge, (~>))
import Signal.Time (every)


foreign import displayLiters :: forall eff c.
                                String
                             -> Number
                             -> Eff (dom :: DOM | eff) Unit

fuelFlow :: forall eff.
            Number
         -> Eff (dom :: DOM | eff)
                (Signal (Eff (dom :: DOM | eff) Unit))
fuelFlow rate = do
  let signalRate = (every 500.0 ~> (\t -> rate))
      signal1 = signalRate  ~> displayLiters "price1"
      signal2 = signalRate  ~> displayLiters "price2"
      signal3 = signalRate  ~> displayLiters "price3"
  pure $ signal1 `merge` signal2 `merge` signal3
