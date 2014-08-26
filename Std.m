MODULE Std;

TYPE OBJECT*   = POINTER TO ObjectRec;
     ObjectRec*= RECORD END;

(* RETURN -1, 0, +1 depending on if "this" should go before,
   is equal, or should go after "that" *)
PROCEDURE (this: OBJECT) CompareTo*(that: OBJECT) : INTEGER;
BEGIN
    IF (this = that) THEN
        RETURN 0
    ELSE
        RETURN 1
    END
END CompareTo;

END Std.