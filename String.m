MODULE String;

IMPORT Std;

TYPE STRING*   = POINTER TO StringRec;
     StringRec*= RECORD (Std.ObjectRec)
                    str* : POINTER TO ARRAY OF CHAR;
                    len* : INTEGER;
                 END;

PROCEDURE String*(c: ARRAY OF CHAR) : STRING;
VAR i: INTEGER;
    s: STRING;
BEGIN
    NEW(s);
    s.len := LEN(c);
    NEW(s.str, s.len);
    FOR i := 0 TO s.len - 1 DO
        s.str^[i] := c[i];
    END;
    RETURN s;
END String;

PROCEDURE (this: STRING) CompareTo*(that: Std.OBJECT) : INTEGER;
BEGIN
    IF this = that THEN
        RETURN 0
    ELSE
        WITH
            that : STRING DO
                IF this.str^ = that.str^ THEN
                    RETURN 0
                ELSIF this.str^ < that.str^ THEN
                    RETURN -1
                ELSE
                    RETURN 1
                END
        ELSE
            RETURN 1
        END
    END
END CompareTo;

PROCEDURE (s: STRING) Length*() : INTEGER;
BEGIN
    RETURN s.len;
END Length;

PROCEDURE (s: STRING) Insert*(pos: INTEGER; c: STRING);
VAR str : POINTER TO ARRAY OF CHAR;
    i, len : INTEGER;
BEGIN
    len := s.len;
    NEW(str, len);
    FOR i := 0 TO len - 1 DO
        str[i] := s.str[i];
    END;
    NEW(s.str, len + c.len - 1);
    (* Head *)
    FOR i := 0 TO pos - 1 DO
        s.str[i] := str[i];
    END;
    (* Insert *)
    FOR i := 0 TO c.len - 1 DO
        s.str[i + pos] := c.str[i];
    END;
    (* Tail *)
    FOR i := pos TO len - 1 DO
        s.str[i + c.len - 1] := str[i];
    END;
    s.len := len + c.len - 1;
END Insert;

PROCEDURE (s: STRING) Append*(c: STRING);
BEGIN
    s.Insert(s.len - 1, c);
END Append;

PROCEDURE (s: STRING) Delete*(start, length: INTEGER);
VAR str : POINTER TO ARRAY OF CHAR;
    i, len : INTEGER;
BEGIN
    len := s.len;
    NEW(str, len);
    FOR i := 0 TO len - 1 DO
        str[i] := s.str[i];
    END;
    NEW(s.str, len - length);
    (* Head *)
    FOR i := 0 TO start - 1 DO
        s.str[i] := str[i];
    END;
    (* Tail *)
    FOR i := start + length  TO len - 1 DO
        s.str[i - length] := str[i];
    END;
    s.len := len - length;
END Delete;

PROCEDURE (s: STRING) Pos*(c: STRING) : INTEGER;
VAR i, j : INTEGER;
    found: BOOLEAN;
BEGIN
    FOR i := 0 TO s.len - c.len DO
        IF s.str[i] = c.str[0] THEN
            found := TRUE;
            FOR j := 0 TO c.len - 2 DO
                IF s.str[i + j] # c.str[j] THEN
                    found := FALSE;
                END;
                IF (j = c.len - 2) & found THEN
                    RETURN i;
                END
            END
        END
    END;
    RETURN 0;
END Pos;

PROCEDURE (s: STRING) Clone*() : STRING;
VAR c : STRING;
    i : INTEGER;
BEGIN
    NEW(c);
    c.len := s.len;
    NEW(c.str, c.len);
    FOR i := 0 TO s.len - 1 DO
        c.str[i] := s.str[i]
    END;
    RETURN c
END Clone;

PROCEDURE (s: STRING) Substring*(start, length: INTEGER) : STRING;
BEGIN
    RETURN s;
END Substring;

END String.
