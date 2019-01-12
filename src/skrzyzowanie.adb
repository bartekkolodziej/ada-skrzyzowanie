with NT_Console;              use NT_Console;
with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Synchronous_Task_Control;
use Ada.Synchronous_Task_Control;

procedure Skrzyzowanie is
   swiatlo: Boolean := True with Atomic;
   type KierunekPoruszania is (lewo, prawo, gora, dol);

   rysowaniePoziom, rysowaniePion : Suspension_Object;

   type samochodPrawo is record
      X: Integer := 1;
      Y: Integer := 13;
   end record;

   type samochodLewo is record
      X: Integer := 70;
      Y: Integer := 16;
   end record;

   type samochodGora is record
      X: Integer := 47;
      Y: Integer := 30;
   end record;

   type samochodDol is record
      X: Integer := 33;
      Y: Integer := 1;
   end record;


   samochodyPrawo: array (1..3) of samochodPrawo;
   samochodyLewo: array (1..3) of samochodLewo;
   samochodyGora: array (1..3) of samochodGora;
   samochodyDol: array (1..3) of samochodDol;



   procedure rysujSkrzyzowanie is
   begin
      Clear_Screen (White);
      Set_Foreground (Black);
      Set_Background (White);
      Goto_XY (0, 0);
      Put ("Symulacja skrzyzowania");
      Goto_XY (60, 0);
      Put ("Press q to change light");
      Goto_XY(60,5);
      Put("Zmiana swiatla za:");
      Goto_XY(10, 10);
      Put("-");
      Goto_XY(11, 10);
      Put("-");
      Goto_XY(12, 10);
      Put("-");
      Goto_XY(13, 10);
      Put("-");
      Goto_XY(14, 10);
      Put("-");
      Goto_XY(15, 10);
      Put("-");
      Goto_XY(16, 10);
      Put("-");
      Goto_XY(17, 10);
      Put("-");
      Goto_XY(18, 10);
      Put("-");
      Goto_XY(19, 10);
      Put("-");
      Goto_XY(20, 10);
      Put("-");
      Goto_XY(21, 10);
      Put("-");
      Goto_XY(22, 10);
      Put("-");
      Goto_XY(23, 10);
      Put("-");
      Goto_XY(24, 10);
      Put("-");
      Goto_XY(25, 10);
      Put("-");
      Goto_XY(26, 10);
      Put("-");
      Goto_XY(27, 10);
      Put("-");
      Goto_XY(28, 10);
      Put("-");
      Goto_XY(29, 10);
      Put("-");
      Goto_XY(30, 10);
      Put("-");


      Goto_XY(10, 20);
      Put("-");
      Goto_XY(11, 20);
      Put("-");
      Goto_XY(12, 20);
      Put("-");
      Goto_XY(13, 20);
      Put("-");
      Goto_XY(14, 20);
      Put("-");
      Goto_XY(15, 20);
      Put("-");
      Goto_XY(16, 20);
      Put("-");
      Goto_XY(17, 20);
      Put("-");
      Goto_XY(18, 20);
      Put("-");
      Goto_XY(19, 20);
      Put("-");
      Goto_XY(20, 20);
      Put("-");
      Goto_XY(21, 20);
      Put("-");
      Goto_XY(22, 20);
      Put("-");
      Goto_XY(23, 20);
      Put("-");
      Goto_XY(24, 20);
      Put("-");
      Goto_XY(25, 20);
      Put("-");
      Goto_XY(26, 20);
      Put("-");
      Goto_XY(27, 20);
      Put("-");
      Goto_XY(28, 20);
      Put("-");
      Goto_XY(29, 20);
      Put("-");
      Goto_XY(30, 20);
      Put("-");

      Goto_XY(50, 10);
      Put("-");
      Goto_XY(51, 10);
      Put("-");
      Goto_XY(52, 10);
      Put("-");
      Goto_XY(53, 10);
      Put("-");
      Goto_XY(54, 10);
      Put("-");
      Goto_XY(55, 10);
      Put("-");
      Goto_XY(56, 10);
      Put("-");
      Goto_XY(57, 10);
      Put("-");
      Goto_XY(58, 10);
      Put("-");
      Goto_XY(59, 10);
      Put("-");
      Goto_XY(60, 10);
      Put("-");
      Goto_XY(61, 10);
      Put("-");
      Goto_XY(62, 10);
      Put("-");
      Goto_XY(63, 10);
      Put("-");
      Goto_XY(64, 10);
      Put("-");
      Goto_XY(65, 10);
      Put("-");
      Goto_XY(66, 10);
      Put("-");
      Goto_XY(67, 10);
      Put("-");
      Goto_XY(68, 10);
      Put("-");
      Goto_XY(69, 10);
      Put("-");
      Goto_XY(70, 10);
      Put("-");


      Goto_XY(50, 20);
      Put("-");
      Goto_XY(51, 20);
      Put("-");
      Goto_XY(52, 20);
      Put("-");
      Goto_XY(53, 20);
      Put("-");
      Goto_XY(54, 20);
      Put("-");
      Goto_XY(55, 20);
      Put("-");
      Goto_XY(56, 20);
      Put("-");
      Goto_XY(57, 20);
      Put("-");
      Goto_XY(58, 20);
      Put("-");
      Goto_XY(59, 20);
      Put("-");
      Goto_XY(60, 20);
      Put("-");
      Goto_XY(61, 20);
      Put("-");
      Goto_XY(62, 20);
      Put("-");
      Goto_XY(63, 20);
      Put("-");
      Goto_XY(64, 20);
      Put("-");
      Goto_XY(65, 20);
      Put("-");
      Goto_XY(66, 20);
      Put("-");
      Goto_XY(67, 20);
      Put("-");
      Goto_XY(68, 20);
      Put("-");
      Goto_XY(69, 20);
      Put("-");
      Goto_XY(70, 20);
      Put("-");


      Goto_XY(30, 0);
      Put("|");
      Goto_XY(30, 1);
      Put("|");
      Goto_XY(30, 2);
      Put("|");
      Goto_XY(30, 3);
      Put("|");
      Goto_XY(30, 4);
      Put("|");
      Goto_XY(30, 5);
      Put("|");
      Goto_XY(30, 6);
      Put("|");
      Goto_XY(30, 7);
      Put("|");
      Goto_XY(30, 8);
      Put("|");
      Goto_XY(30, 9);
      Put("|");
      Goto_XY(30, 10);
      Put("|");


      Goto_XY(50, 0);
      Put("|");
      Goto_XY(50, 1);
      Put("|");
      Goto_XY(50, 2);
      Put("|");
      Goto_XY(50, 3);
      Put("|");
      Goto_XY(50, 4);
      Put("|");
      Goto_XY(50, 5);
      Put("|");
      Goto_XY(50, 6);
      Put("|");
      Goto_XY(50, 7);
      Put("|");
      Goto_XY(50, 8);
      Put("|");
      Goto_XY(50, 9);
      Put("|");
      Goto_XY(50, 10);
      Put("|");


      Goto_XY(30, 20);
      Put("|");
      Goto_XY(30, 21);
      Put("|");
      Goto_XY(30, 22);
      Put("|");
      Goto_XY(30, 23);
      Put("|");
      Goto_XY(30, 24);
      Put("|");
      Goto_XY(30, 25);
      Put("|");
      Goto_XY(30, 26);
      Put("|");
      Goto_XY(30, 27);
      Put("|");
      Goto_XY(30, 28);
      Put("|");
      Goto_XY(30, 29);
      Put("|");
      Goto_XY(30, 30);
      Put("|");


      Goto_XY(50, 20);
      Put("|");
      Goto_XY(50, 21);
      Put("|");
      Goto_XY(50, 22);
      Put("|");
      Goto_XY(50, 23);
      Put("|");
      Goto_XY(50, 24);
      Put("|");
      Goto_XY(50, 25);
      Put("|");
      Goto_XY(50, 26);
      Put("|");
      Goto_XY(50, 27);
      Put("|");
      Goto_XY(50, 28);
      Put("|");
      Goto_XY(50, 29);
      Put("|");
      Goto_XY(50, 30);
      Put("|");

   end rysujSkrzyzowanie;

   task samochodyPoziomo;
   task body samochodyPoziomo is
   begin
      loop
         delay(0.13);

         Suspend_Until_True(rysowaniePoziom);
         for El of samochodyPrawo loop
            if swiatlo or (not swiatlo and El.X < 28) or El.X > 30 then
               El.X := El.X + 1;
               Goto_XY(El.X-1, El.Y);
               Put("  ");
               Goto_XY(El.X, El.Y);
               Put(">");
            end if;

            if El.X > 70 then
               Goto_XY(70, El.Y);
               Put("     ");
               El.X := 1;
            end if;

         end loop;

         for El of samochodyLewo loop
            if swiatlo or (not swiatlo and El.X > 52) or El.X < 48 then
               El.X := El.X - 1;
               Goto_XY(El.X+1, El.Y);
               Put("  ");
               Goto_XY(El.X, El.Y);
               Put("<");
            end if;

            if El.X < 1 then
               Goto_XY(0, El.Y);
               Put("     ");
               El.X := 70;
            end if;
         end loop;
         Set_True(rysowaniePion);
      end loop;
   end samochodyPoziomo;

   task samochodyPionowo;
   task body samochodyPionowo is
   begin
      loop
         delay(0.13);
         Suspend_Until_True(rysowaniePion);
         for El of samochodyDol loop
            if not swiatlo or (swiatlo and El.Y < 8) or El.Y > 12 then
               El.Y := El.Y + 1;
               Goto_XY(El.X, El.Y-1);
               Put("  ");
               Goto_XY(El.X, El.Y);
               Put("V");
            end if;

            if El.Y > 30 then
               Goto_XY(El.X, 31);
               Put("    ");
               El.Y := 1;
            end if;
         end loop;

         for El of samochodyGora loop
            if not swiatlo or (swiatlo and El.Y > 22) or El.Y < 18 then
               El.Y := El.Y - 1;
               Goto_XY(El.X, El.Y+1);
               Put("  ");
               Goto_XY(El.X, El.Y);
               Put("^");
            end if;

            if El.Y < 1 then
               Goto_XY(El.X, 0);
               Put("     ");
               El.Y := 30;
            end if;
         end loop;
         Set_True(rysowaniePoziom);
      end loop;
   end samochodyPionowo;

   task licznik;
   task body licznik is
   begin
      loop
         Goto_XY(80, 5);
         Put('9');
         delay(1.0);
         Goto_XY(80, 5);
         Put('8');
         delay(1.0);
         Goto_XY(80, 5);
         Put('7');
         delay(1.0);
         Goto_XY(80, 5);
         Put('6');
         delay(1.0);
         Goto_XY(80, 5);
         Goto_XY(80, 5);
         Put('5');
         delay(1.0);
         Goto_XY(80, 5);
         Put('4');
         delay(1.0);
         Goto_XY(80, 5);
         Put('3');
         delay(1.0);
         Goto_XY(80, 5);
         Put('2');
         delay(1.0);
         Goto_XY(80, 5);
         Put('1');
         delay(1.0);
         Goto_XY(80, 5);
         Put('0');
         swiatlo := not swiatlo;
      end loop;
   end licznik;

   Zn: Character;
begin
   Set_True(rysowaniePion);
   rysujSkrzyzowanie;
   loop
      Get_Immediate(Zn);
      if Zn in 'q' | 'Q' then
         swiatlo := not swiatlo;
      end if;
   end loop;
end Skrzyzowanie;
