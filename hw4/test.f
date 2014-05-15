/* Examples for testing */
true;
if false then true else false;

/* Defines a "macro" id */
id = (\x : Bool . x);

(\x : Bool . x) true;
id false;

/* Should not work! */
id id;

(\x:Bool . \x:Bool . x) true false;
