module KeyPad.Signal (setPreset) where

import Data.Array
import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.Foldable (foldr)
import Data.Traversable (sequence)
import Prelude (Unit, bind, flip, pure, unit, ($), (<$>))
import Signal (Signal, constant, merge, (~>))


foreign import signalKey :: forall eff c.
                            String
                         -> (c -> Signal c)
                         -> Eff (dom :: DOM | eff) (Signal Number)

foreign import displayPreset :: forall eff.
                                Number
                             -> Eff (dom :: DOM | eff) Unit


foreign import clearPreset :: forall eff.
                              Number
                           -> Eff (dom :: DOM | eff) Unit


keys :: Array String
keys = ["key1",
        "key2",
        "key3",
        "key4",
        "key5",
        "key6",
        "key7",
        "key8",
        "key9",
        "key0"]

setPreset :: forall eff . Eff (dom :: DOM | eff)
                              (Signal (Eff (dom :: DOM | eff) Unit))
setPreset = do
  clear <- signalKey "clear" constant
  signals <- sequence $ (flip signalKey) constant <$> keys
  let signal = foldr merge (constant 0.0) signals
  pure $ (signal ~> displayPreset) `merge` (clear ~> clearPreset)
