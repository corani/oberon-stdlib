MODULE Map;

IMPORT Std;

TYPE Node   = POINTER TO NodeRec;
     NodeRec= RECORD
                key  : Std.OBJECT;
                value: Std.OBJECT;
                next : Node;
              END;
     MAP*   = POINTER TO MapRec;
     MapRec = RECORD
                nodes : Node;
                len   : INTEGER;
              END;

PROCEDURE Map*() : MAP;
VAR m : MAP;
BEGIN
    NEW(m);
    m.len := 0;
    m.nodes := NIL;
    RETURN m
END Map;

PROCEDURE (m: MAP) Clear*();
BEGIN
    m.len := 0;
    m.nodes := NIL;
END Clear;

PROCEDURE (m: MAP) Length*() : INTEGER;
BEGIN
    RETURN m.len
END Length;

PROCEDURE (m: MAP) Put*(key: Std.OBJECT; value: Std.OBJECT);
VAR node, prev : Node;
BEGIN
    prev := NIL;
    node := m.nodes;
    WHILE (node # NIL) & (node.key.CompareTo(key) < 0) DO
        prev := node;
        node := node.next
    END;
    NEW(node);
    node.key   := key;
    node.value := value;
    IF (prev = NIL) THEN
        (* Insert at start *)
        node.next := m.nodes;
        m.nodes   := node;
        INC(m.len);
    ELSIF (prev.next = NIL) THEN
        (* Insert at end *)
        prev.next := node;
        INC(m.len);
    ELSIF (prev.next.key.CompareTo(key) = 0) THEN
        (* Replace existing *)
        node.next := prev.next.next;
        prev.next := node;
    ELSE
        (* Insert *)
        node.next := prev.next;
        prev.next := node;
        INC(m.len);
    END;
    
END Put;

PROCEDURE (m: MAP) Get*(key: Std.OBJECT) : Std.OBJECT;
VAR node : Node;
BEGIN
    node := m.nodes;
    WHILE (node # NIL) DO
        IF node.key.CompareTo(key) = 0 THEN
            RETURN node.value;
        END;
        node := node.next
    END;
    RETURN NIL
END Get;

PROCEDURE (m: MAP) KeyAt*(pos: INTEGER) : Std.OBJECT;
VAR i    : INTEGER;
    node : Node;
BEGIN
    IF (pos < 0) OR (pos > m.len - 1) THEN
        RETURN NIL
    ELSE
        node := m.nodes;
        FOR i := 0 TO pos - 1 DO
            node := node.next
        END;
        RETURN node.key
    END
END KeyAt;

PROCEDURE (m: MAP) ValueAt*(pos: INTEGER) : Std.OBJECT;
VAR i    : INTEGER;
    node : Node;
BEGIN
    IF (pos < 0) OR (pos > m.len - 1) THEN
        RETURN NIL
    ELSE
        node := m.nodes;
        FOR i := 0 TO pos - 1 DO
            node := node.next
        END;
        RETURN node.value
    END
END ValueAt;

END Map.