with NT_Console;              use NT_Console;
with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Synchronous_Task_Control;
use Ada.Synchronous_Task_Control;
with Ada.Numerics.Discrete_Random;
with Ada.Exceptions;
use Ada.Exceptions;

procedure Skrzyzowanie is
   type Rand_Range is range 1..30;
   package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);

   wylaczonaSygnalizacja: Boolean := False with Atomic;
   swiatlo: Boolean := True with Atomic;
   predkosc: Duration := 0.15 with Atomic;
   koniec: Boolean := False with Atomic;
   rysowaniePoziom, rysowaniePion : Suspension_Object;
   input: Character;

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


   samochodyPrawo: array (1..11) of samochodPrawo;
   samochodyLewo: array (1..11) of samochodLewo;
   samochodyGora: array (1..11) of samochodGora;
   samochodyDol: array (1..11) of samochodDol;

   function randomInt return Integer is
      len : Integer;
      seed : Rand_Int.Generator;
      Num : Rand_Range;
   begin
      Rand_Int.Reset(seed);
      Num := Rand_Int.Random(seed);
      len := Integer(Num);
      return len;
   end;

   procedure rysujSkrzyzowanie is
   begin
      Clear_Screen (White);
      Set_Foreground (Black);
      Set_Background (White);
      Goto_XY (60, 0);
      Put ("Wylaczenie sygnalizacji: C");
      Goto_XY(60,1);
      Put ("Zmiana swiatla: Q");
      Goto_XY(60,2);
      Put("Zmiana predkosci: A, B");
      Goto_XY(60,3);
      Put("Wyjscie: X");
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

   procedure randomizuj is
   begin
      for E of samochodyPrawo loop
         E.X := E.X + randomInt;
      end loop;
      for E of samochodyLewo loop
         E.X := E.X - randomInt;
      end loop;
      for E of samochodyGora loop
         E.Y := E.Y - randomInt;
      end loop;
      for E of samochodyDol loop
         E.Y := E.Y + randomInt;
      end loop;
   end randomizuj;

   task samochodyPoziomo;
   task body samochodyPoziomo is
   begin
      loop
         delay(predkosc);

         Suspend_Until_True(rysowaniePoziom);
         for El of samochodyPrawo loop
            for e of samochodyPrawo loop
               if El.X /= e.X and El.X + 1 = e.X then
                  goto skok1;
               end if;
            end loop;

            if swiatlo or (not swiatlo and El.X < 28) or El.X > 30 or wylaczonaSygnalizacja then
               El.X := El.X + 1;
               Goto_XY(El.X-1, El.Y);
               Put("  ");
               Goto_XY(El.X, El.Y);
               Put("O");
            end if;

            if El.X > 70 then
               Goto_XY(70, El.Y);
               Put("     ");
               El.X := 1;
            end if;
            <<skok1>>
         end loop;

         for El of samochodyLewo loop
            for e of samochodyLewo loop
               if El.X /= e.X and El.X - 1 = e.X then
                  goto skok2;
               end if;
            end loop;
            if swiatlo or (not swiatlo and El.X > 52) or El.X < 48 or wylaczonaSygnalizacja then
               El.X := El.X - 1;
               Goto_XY(El.X+1, El.Y);
               Put("  ");
               Goto_XY(El.X, El.Y);
               Put("O");
            end if;

            if El.X < 1 then
               Goto_XY(0, El.Y);
               Put("     ");
               El.X := 70;
            end if;
            <<skok2>>
         end loop;
         Set_True(rysowaniePion);
         exit when koniec;
      end loop;
   end samochodyPoziomo;

   task samochodyPionowo;
   task body samochodyPionowo is
   begin
      loop
         delay(predkosc);
         Suspend_Until_True(rysowaniePion);
         for El of samochodyDol loop
            for e of samochodyDol loop
               if El.Y /= e.Y and El.Y + 1 = e.Y then
                  goto skok3;
               end if;
            end loop;

            for e of samochodyPrawo loop
               if El.Y + 1 = e.Y and (El.X = e.X or El.X - 1 = e.X) then
                  goto skok3;
               end if;
            end loop;

            for e of samochodyLewo loop
               if El.Y + 1 = e.Y and (El.X = e.X or El.X + 1 = e.X) then
                  goto skok3;
               end if;
            end loop;

            if not swiatlo or (swiatlo and El.Y < 7) or El.Y > 10 or wylaczonaSygnalizacja then
               El.Y := El.Y + 1;
               Goto_XY(El.X, El.Y-1);
               Put("  ");
               Goto_XY(El.X, El.Y);
               Put("O");
            end if;

            if El.Y > 30 then
               Goto_XY(El.X, 31);
               Put("    ");
               El.Y := 1;
            end if;
            <<skok3>>
         end loop;

         for El of samochodyGora loop
            for e of samochodyGora loop
               if El.Y /= e.Y and El.Y - 1 = e.Y then
                  goto skok4;
               end if;
            end loop;

            for e of samochodyPrawo loop
               if El.Y - 1 = e.Y and (El.X = e.X or El.X - 1 = e.X) then
                  goto skok4;
               end if;
            end loop;

            for e of samochodyLewo loop
               if El.Y - 1 = e.Y and (El.X = e.X or El.X + 1 = e.X) then
                  goto skok4;
               end if;
            end loop;


            if not swiatlo or (swiatlo and El.Y > 24) or El.Y < 22 or wylaczonaSygnalizacja then
               El.Y := El.Y - 1;
               Goto_XY(El.X, El.Y+1);
               Put("  ");
               Goto_XY(El.X, El.Y);
               Put("O");
            end if;

            if El.Y < 1 then
               Goto_XY(El.X, 0);
               Put("     ");
               El.Y := 30;
            end if;
            <<skok4>>
         end loop;
         Set_True(rysowaniePoziom);
         exit when koniec;
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
         exit when koniec;
      end loop;
   exception
      when E: others =>
         Put_Line("Error: licznik");
         Put_Line(Exception_Name (E) & ": " & Exception_Message (E));
   end licznik;

begin
   Set_True(rysowaniePion);
   rysujSkrzyzowanie;
   randomizuj;
   loop
      Get_Immediate(input);
      if input in 'q' | 'Q' then
         swiatlo := not swiatlo;
      end if;
      if input in 'a' | 'A' then
         predkosc := predkosc - 0.01;
      end if;
      if input in 'b' | 'B' then
         predkosc := predkosc + 0.01;
      end if;
      if input in 'c' | 'C' then
         wylaczonaSygnalizacja := not wylaczonaSygnalizacja;
      end if;
      exit when input in 'x' | 'X';
   end loop;
   koniec := True;
exception
   when E: others =>
      Put_Line("Error: Watek glowny");
      Put_Line(Exception_Name (E) & ": " & Exception_Message (E));
end Skrzyzowanie;
