MODULE Vector;

TYPE OBJECT*   = POINTER TO ObjectRec;
     ObjectRec = RECORD END;
     Node      = POINTER TO NodeRec;
     NodeRec   = RECORD
                    data : OBJECT;
                    next : Node;
                 END;
     VECTOR*   = POINTER TO VectorRec;
     VectorRec = RECORD
                    len  : INTEGER;
                    head : Node;
                    tail : Node;
                 END;

VAR vec : VECTOR;
    elm : OBJECT;

PROCEDURE Vector*() : VECTOR;
VAR vec : VECTOR;
BEGIN
    NEW(vec);
    vec.len := 0;
    vec.head := NIL;
    vec.tail := NIL;
    RETURN vec;
END Vector;

PROCEDURE (vec: VECTOR) Length*() : INTEGER;
BEGIN
    RETURN vec.len;
END Length;

PROCEDURE (vec: VECTOR) PushBack*(e: OBJECT);
VAR node : Node;
BEGIN
    NEW(node);
    node.next := NIL;
    node.data := e;
    IF vec.head = NIL THEN
        vec.head := node;
    ELSE
        vec.tail.next := node;
    END;
    vec.tail := node;
    INC(vec.len);
END PushBack;

PROCEDURE (vec: VECTOR) PopBack*() : OBJECT;
VAR prev, node : Node;
BEGIN
    IF vec.tail = NIL THEN
        (* Empty *)
        RETURN NIL
    ELSIF vec.head = vec.tail THEN
        (* Only one node *)
        node := vec.head;
        vec.head := NIL;
        vec.tail := NIL;
        vec.len := 0;
        RETURN node.data
    ELSE
        (* More than one node *)
        prev := vec.head;
        WHILE prev.next # vec.tail DO
            prev := prev.next
        END;
        node := prev.next;
        prev.next := NIL;
        vec.tail := prev;
        DEC(vec.len);
        RETURN node.data
    END
END PopBack;

PROCEDURE (vec: VECTOR) Head*() : OBJECT;
BEGIN
    IF vec.head = NIL THEN
        RETURN NIL
    ELSE
        RETURN vec.head.data;
    END
END Head;

PROCEDURE (vec: VECTOR) Tail*() : OBJECT;
BEGIN
    IF vec.tail = NIL THEN
        RETURN NIL
    ELSE
        RETURN vec.tail.data;
    END
END Tail;

PROCEDURE (vec: VECTOR) At*(pos : INTEGER) : OBJECT;
VAR i    : INTEGER;
    node : Node;
BEGIN
    IF (pos < 0) OR (pos > vec.len - 1) THEN
        RETURN NIL;
    ELSE
        node := vec.head;
        FOR i := 0 TO pos - 1 DO
            node := node.next;
        END;
        RETURN node.data;
    END
END At;

PROCEDURE (vec: VECTOR) Delete*(pos: INTEGER);
VAR i    : INTEGER;
    node : Node;
BEGIN
    IF (pos < 0) OR (pos > vec.len - 1) THEN
        (* Out of Range = NOP *)
    ELSIF pos = 0 THEN
        (* First *)
        vec.head := vec.head.next;
        DEC(vec.len);
    ELSE
        (* Middle/Last *)
        node := vec.head;
        FOR i := 0 TO pos - 1 DO
            node := node.next
        END;
        node.next := NIL;
        DEC(vec.len)
    END
END Delete;

PROCEDURE (vec: VECTOR) Insert*(pos: INTEGER; e: OBJECT);
VAR i    : INTEGER;
    node : Node;
    prev : Node;
BEGIN
    IF (pos < 0) THEN pos := 0 END;
    IF (pos > vec.len - 1) THEN pos := vec.len - 1 END;
    NEW(node);
    node.data := e;
    IF pos = 0 THEN
        (* Head *)
        node.next := vec.head;
        vec.head := node;
    ELSIF pos = vec.len - 1 THEN
        (* Tail *)
        node.next := NIL;
        vec.tail.next := node;
        vec.tail := node;
    ELSE
        (* Middle *)
        prev := vec.head;
        FOR i := 0 TO pos - 2 DO
            prev := prev.next;
        END;
        node.next := prev.next;
        prev.next := node;
    END;
    INC(vec.len);
END Insert;

PROCEDURE (vec: VECTOR) Clear*();
BEGIN
    vec.head := NIL;
    vec.tail := NIL;
    vec.len  := 0;
END Clear;

PROCEDURE (vec: VECTOR) Swap*(p1, p2: INTEGER);
VAR i            : INTEGER;
    prev1, prev2 : Node;
    temp1, temp2 : Node;
BEGIN
    IF (p1 < 0) OR (p1 > vec.len - 1) OR (p2 < 0) OR (p2 > vec.len - 1) THEN
        (* Out of Range = NOP *)
    ELSIF p1 = p2 THEN
        (* The same = NOP *)
    ELSIF (p1 = vec.head) & (p2 = vec.tail) THEN
        (* Fix head & tail *)
    ELSIF p1 = vec.head THEN
        (* Fix head *)
    ELSIF (p2 = vec.head) & (p1 = vec.tail) THEN
        (* Fix head & tail *)
    ELSIF p2 = vec.head THEN
        (* Fix head *)
    ELSIF p1 = vec.tail THEN
        (* Fix tail *)
    ELSIF p2 = vec.tail THEN
        (* FIX tail *)
    ELSE
        (* Both are in the middle *)
    END
END Swap;

END Vector.