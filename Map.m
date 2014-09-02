MODULE Map;

IMPORT Std, Vector;

TYPE PAIR*  = POINTER TO PairRec;
     PairRec= RECORD
                key*  : Std.OBJECT;
                value*: Std.OBJECT
              END;
     MAP*   = POINTER TO MapRec;
     MapRec = RECORD
                vec   : VECTOR;
                len   : INTEGER
              END;

PROCEDURE Pair*(key : Std.OBJECT, value : Std.OBJECT) : PAIR;
VAR p : PAIR;
BEGIN
    NEW(p);
    p.key := key;
    p.value := value;
    RETURN p
END Pair;

PROCEDURE Map*() : MAP;
VAR m : MAP;
BEGIN
    NEW(m);
    m.len := 0;
    m.vec = Vector.Vector();
    RETURN m
END Map;

PROCEDURE (m: MAP) Clear*();
BEGIN
    m.len := 0;
    m.vec.Clear()
END Clear;

PROCEDURE (m: MAP) Length*() : INTEGER;
BEGIN
    RETURN m.len
END Length;

PROCEDURE (m: MAP) Put*(key: Std.OBJECT; value: Std.OBJECT);
VAR i : INTEGER;
    e : Std.OBJECT;
    p : PAIR;
BEGIN
    FOR i := 0 TO m.len - 1 DO
        e := m.vec.At(i);
        WITH e: PAIR DO
            CASE e.key.CompareTo(key) OF
               -1 : (* Continue *)
            |   0 : (* Replace *)
                    e.value := value;
                    RETURN
            |   1 : (* Insert *)
                    p := Pair(key, value);
                    m.vec.Insert(i, p);
                    INC(m.len);
                    RETURN
            END
        END
    END    
END Put;

PROCEDURE (m: MAP) PairAt*(pos: INTEGER) : PAIR;
VAR e : Std.OBJECT;
BEGIN
    e := m.vec.At(pos);
    RETURN e(PAIR)
END PairAt;

PROCEDURE (m: MAP) Get*(key: Std.OBJECT) : Std.OBJECT;
VAR i : INTEGER;
    p : PAIR;
BEGIN
    FOR i := 0 TO m.len - 1 DO
        p := m.PairAt(i);
        CASE p.key.CompareTo(key) DO
           -1 : (* Continue *)
        |   0 : (* Found *)
                RETURN p.value
        |   1 : (* Iterated past *)
                EXIT
        END
    END;
    RETURN NIL
END Get;

PROCEDURE (m: MAP) KeyAt*(pos: INTEGER) : Std.OBJECT;
BEGIN
    RETURN m.PairAt(pos).key
END KeyAt;

PROCEDURE (m: MAP) ValueAt*(pos: INTEGER) : Std.OBJECT;
BEGIN
    RETURN m.PairAt(pos).value
END ValueAt;

END Map.