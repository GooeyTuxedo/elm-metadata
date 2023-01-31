module Data.Gooey.Attribute exposing (Attribute)

import Data.Gooey.Attribute.Age exposing (Age)
import Data.Gooey.Attribute.BodyType exposing (BodyType)
import Data.Gooey.Attribute.Disposition exposing (Disposition)
import Data.Gooey.Attribute.Generation exposing (Generation)
import Data.Gooey.Attribute.IsAsleep exposing (IsAsleep)
import Data.Gooey.Attribute.IsBuried exposing (IsBuried)
import Data.Gooey.Attribute.MitosisCredits exposing (MitosisCredits)
import Data.Gooey.Attribute.ParentID exposing (ParentID)


type Attribute
    = Age
    | BodyType
    | Disposition
    | Generation
    | Health
    | IsAsleep
    | IsBuried
    | MitosisCredits
    | ParentID
