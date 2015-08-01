CREATE OR REPLACE PROCEDURE equal_example AS
  TYPE charTable IS TABLE OF VARCHAR2(10);
     emp1 charTable;
      emp2 charTable;
      emp3 charTable;
      result BOOLEAN;
    BEGIN
      emp1 := charTable('A', 'B', 'C');
      emp2 := charTable('A', 'C','B');
     emp3 := charTable('B', 'C', 'D');

     result := emp1 = emp2;
     IF result THEN
       DBMS_OUTPUT.PUT_LINE('emp1 equal to emp2' );
     else 
     DBMS_OUTPUT.PUT_LINE('emp1 Not equal to emp2');
     END IF;

   END equal_example;
/

