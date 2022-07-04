SELECT id :: int8
    , name :: text
    , color :: text?
    , background :: text?
FROM objects
WHERE flag
ORDER BY orderc, id
LIMIT 1;