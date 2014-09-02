MODULE Map;

IMPORT Std, Vector;

TYPE PAIR*  = POINTER TO PairRec;
     PairRec= RECORD
                key   : Std.OBJECT;
                value : Std.OBJECT
              END;
     MAP*   = POINTER TO MapRec;
     MapRec = RECORD
                vec   : VECTOR;
                len   : INTEGER;
              END;

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
    m.vec.Clear();
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
                    NEW(p);
                    p.key := key;
                    p.value := value;
                    m.vec.Insert(i, p);
                    INC(m.len);
                    RETURN
            END
        END
    END    
END Put;

PROCEDURE (m: MAP) Get*(key: Std.OBJECT) : Std.OBJECT;
VAR i : INTEGER;
    e : Std.OBJECT;
BEGIN
    FOR i := 0 TO m.len - 1 DO
        e := m.vec.At(1);
        WITH e: PAIR DO
            IF (e.key.CompareTo(key) = 0 THEN
                RETURN e.value
            END
        END
    END;
    RETURN NIL
END Get;

PROCEDURE (m: MAP) KeyAt*(pos: INTEGER) : Std.OBJECT;
VAR i : INTEGER;
    e : Std.OBJECT;
BEGIN
    IF (pos >= 0) AND (pos <= m.len - 1) THEN
        e := m.vec.At(pos);
        WITH e: PAIR DO
            RETURN e.key
        END
    END;
    RETURN NIL
END KeyAt;

PROCEDURE (m: MAP) ValueAt*(pos: INTEGER) : Std.OBJECT;
VAR i : INTEGER;
    e : Std.OBJECT;
BEGIN
    IF (pos >= 0) AND (pos <= m.len - 1) THEN
        e := m.vec.At(pos);
        WITH e: PAIR DO
            RETURN e.value
        END
    END;
    RETURN NIL
END ValueAt;

END Map.