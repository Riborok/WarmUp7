Program WarmUp7;
{
 The program should calculate the division of n numbers in the entered number system
}

{$APPTYPE CONSOLE}

Uses
  System.SysUtils;

Const
  MaxSize=200;
  MaxAmount=50;
  NSAlphabet = '0123456789ABCDEFGHIJ';
  //MaxSize - maximum amount of digits for entered numbers
  //MaxAmount - maximum amount of numbers
  //NSAlphabet - transfer between symbols and numbers

Var
  Num1 :array[1..MaxSize] of SmallInt;
  Num2 :array[1..(MaxSize * MaxAmount)] of SmallInt;
  Num3 :array[1..MaxSize] of SmallInt;
  Results :array[1..(MaxSize * MaxAmount)] of SmallInt;
  str :string;
  MaxNS, NS, Amount, j, Res, CarryRes, Sum, CarrySum : ShortInt;
  Prod, CarryProd, PosElement : Word;
  Len1, Len2, Len3, CurrElInQuotient, k,  i, p, ResDiv, ToPosEl, CurrPosEl: Word;
  flag, FoundLarger, DelZero, RemLessDiv: boolean;
  //Num1 - array of digits of the first number (divider)
  //Num2 - array of digits of the second numbers (denominator)
  //Num3 - array of digits of the third numbers (multiplier in the denominator)
  //Results - at first product of two numbers in the denominator, then the result of dividing two numbers
  //str - string variable for writing numbers
  //MaxNS - maximum number system
  //NS - number system
  //Amount - amount of numbers
  //Res - residual of digits in the selected range
  //CarryRes - carry for residual
  //Sum - sum of all digits in the certain category (for ProdNums)
  //CarrySum - �arry 1 (if there is) to the next element (for Sum)
  //Prod - product of the digits of the first and second number
  //CarryProd - �arry the digit (if there is) to the next element (for Prod)
  //PosElement - the current position of the element in the multiplication
  //Len1 - the length of the first number
  //Len2 - the length of the second number
  //Len3 - the length of the third number
  //CurrElInQuotient - current element in quotient
  //i, j, k, p - cycle counter
  //ResDiv - result of dividing a part of digits
  //ToPosEl - up to which element will divide
  //CurrPosEl - current position in the divider
  //flag - flag to confirm the correctness of entering numbers
  //FoundLarger - when a larger number is found, the variable will become true
  //DelZero - variable to remove the unnecessary zeros (if there is)
  //RemLessDiv - when the remainder of the numerator (Num1) after dividing
  //the previous elements is less than the denominator (Num2), the variable will be true

Begin

  MaxNS := length(NSAlphabet);
  Writeln('Enter number system (maximum number system is ',MaxNS,', minimal is 2). The program will calculate their division.');
  Readln(NS);

  Writeln('Enter amount of numbers (no more than ',MaxAmount,' and more than 1)');
  Readln(Amount);

  //Validation of input
  if (NS > MaxNS) or (NS<=1) or (Amount > MaxAmount) or (Amount<=1) then
    Writeln('Incorrect data. Restart the program')
  else
  begin

    //Declaring available symbols and their value
    Writeln;
    Writeln('Available symbols on the ',NS,'th number system and their number system:');
    for i := 0 to (NS-1) do
      Writeln('Symbol ', NSAlphabet[i+1],' Value = ',i);
    Writeln;

    Writeln('Attention! Numerator must be >= denominator');
    Writeln('Enter numbers (no more than ',MaxSize,' digits).');

    //Cycle with postcondition for entering correct data.
    Repeat

      //Initialize the flag
      flag:= False;

      //Read the first entered number and check for correctness.
      Readln(str);

      //Find length of the first number
      Len1:= length(str);
      if len1>MaxSize then
        flag:= True;

      //Reset the first number for the input
      FillChar(Num1, length(Num1), 0);

      //Write the first entered number in mirrored view to an array
      i:=1;
      while (i<=Len1) and (flag = False) do
      begin

        //Transfer to numerical value (-1 because numbering in delphi starts from 1)
        Num1[i]:= Pos(str[Len1-i+1], NSAlphabet) - 1;

        //Checking for correct input in the number system
        //Num1[i] will be <0 if the symbol is not in NSAlphabet
        if (Num1[i]<0) or (Num1[i]>=NS) then
          flag:= True;

        //Modernize i
        i:= i + 1;
      end;

      if flag = True then
        Writeln('Invalid number entry. Try again');

    Until flag = False;

    Writeln('/');

    //Cycle with postcondition for entering correct data.
    Repeat

      //Initialize the flag
      flag:= False;

      //Read the second number and check for correctness.
      Readln(str);

      //Find length of the first number
      Len2:= length(str);
      if len2>MaxSize then
        flag:= True;

      //Reset the second number for the input
      FillChar(Num2, length(Num2), 0);

      //Write the second number in mirrored view to an array
      i:=1;
      while (i<=Len2) and (flag = False) do
      begin

        //Transfer to numerical value (-1 because numbering in delphi starts from 1)
        Num2[i]:= Pos(str[Len2-i+1], NSAlphabet) - 1;

        //Checking for correct input in the number system
        //Num2[i] will be <0 if the symbol is not in NSAlphabet
        if (Num2[i]<0) or (Num2[i]>=NS) then
          flag:= True;

        //Modernize i
        i:= i + 1;
      end;

      if flag = True then
        Writeln('Invalid number entry. Try again');

    Until flag = False;





    //The cycle go (Amount-2) times to multiply all the numbers in the denominator
    for j := 1 to (Amount-2) do
    begin

      Writeln('/');

      //Cycle with postcondition for entering correct data.
      Repeat

        //Initialize the flag
        flag:= False;

        //Read the third number and check for correctness.
        Readln(str);

        //Find length of the third number
        Len3:= length(str);
        if len3>MaxSize then
          flag:= True;

        //Reset the third number for the input
        FillChar(Num3, length(Num3), 0);

        //Write the third number in mirrored view to an array
        i:=1;
        while (i<=Len3) and (flag = False) do
        begin

          //Transfer to numerical value (-1 because numbering in delphi starts from 1)
          Num3[i]:= Pos(str[Len3-i+1], NSAlphabet) - 1;

          //Checking for correct input in the number system
          //Num3[i] will be <0 if the symbol is not in NSAlphabet
          if (Num3[i]<0) or (Num3[i]>=NS) then
            flag:= True;

          //Modernize i
          i:= i + 1;
        end;

        if flag = True then
          Writeln('Invalid number entry. Try again');

      Until flag = False;

      //Multiply the digits of the second number by the third number
      for i := 1 to Len2 do
      begin
        for k := 1 to Len3 do
        begin

          //�alculate at what position in the multiplication the element now
          PosElement:= k+i-1;

          //Starting to multiply the last digits of the numbers (in the mirrored view it is first)
          //and add the carry (if there is).
          Prod:= Num2[i] * Num3[k] + CarryProd;

          //The integer part of dividing by NS is the carry that will go to the next element
          CarryProd:= Prod div NS;

          //Find the sum of digits in a current position element
          Sum:= (CarrySum + Results[PosElement] + (Prod mod NS));

          //The integer part of dividing by NS is the carry that will go to the next element
          CarrySum:= Sum div NS;

          //The modulo of the Sum by NS is the digit in the Results
          Results[PosElement] := Sum mod NS;

          //If there is a carry on the last digit of the second number, then add a carry to the next element
          if k = Len3 then
          begin

            if CarryProd >=1 then
            begin

              //c in the next element is equal to the carry, since this element is new for multiplied
              Results[PosElement+1]:=CarryProd;

              //Carry is assigned 0 for the next iterations
              CarryProd:=0;
            end;

            if CarrySum = 1 then
            begin

              //c in the next element is equal to the sum of carry and c in the next element,
              //since this element was already for added
              Results[PosElement+1]:= CarrySum + Results[PosElement+1];

              //Carry is assigned 0 for the next iterations
              CarrySum:=0;
            end;

          end;
        end;

        //If in the last digits of the two numbers there is a number in the next position,
        //then the current position element increases
        if (i = Len2) and (Results[PosElement+1]>0) then
          PosElement:= PosElement + 1;

      end;

      //For the next iteration, the first number becomes the product of the previous.
      for i := 1 to PosElement do
        Num2[i]:= Results[i];

      //Update the length of the first number
      Len2:= PosElement;

      //Reset the carryes for the operations
      CarrySum:= 0;
      CarryProd:= 0;

      //Reset the product of nums for the iteration
      FillChar(Results, length(Results), 0);

    end;





    //Check that the number of digits in the numerator is >= digits in the denominator
    if Len2>Len1 then
      flag:= True
    else
    begin

      //Checking the condition: numerator >= denominator
      i:= Len1;
      FoundLarger:= False;
      while (i>=1) and (FoundLarger = False) do
      begin

        //If a>b, the sign for the first number is '+', for the second '-' (a-b).
        if Num1[i]>Num2[i] then
          FoundLarger:= True

        //If b>a, the sign for the first number is '-', for the second '+' (b-a).
        else if Num2[i]>Num1[i] then
        begin
          //Exit the cycle because we found a larger number.
          FoundLarger:= True;

          flag:= True;
        end;

        //Modernize i
        i:= i - 1;
      end;

    end;

    //Checking the condition numerator >= denominator
    if flag = True then
      Writeln('Error! The denominator is greater than the numerator! Restart the program')
    else
    begin

      //Initialize the variables (considering that they are written in mirrored view)
      ToPosEl:= Len1 - Len2 + 2; //+2 since at the beginning of the cycle will decrease by 1
      CurrPosEl:= len1;
      CurrElInQuotient:=0;
      repeat

        //Initialize variables to remove the unnecessary zeros (if there is)
        DelZero:= False;
        i:=CurrPosEl;
        j:= ToPosEl;
        while (i>=j) and (DelZero = False) do
        begin

          //When found the number (1..NS) exit the cycle
          if (Num1[i] > 0) then
            DelZero:= True

          //Else (if CurrPosEl>1) move the current position of the element to the left
          else if (CurrPosEl>1) then
          begin

            //Also move ToPosEl (one time less than CurrPosEl to maintain the logic of division into a column)
            if (i<>CurrPosEl) then
              ToPosEl:= ToPosEl - 1;

            //Reduce CurrPosEl
            CurrPosEl:= CurrPosEl - 1;
          end;

          //Modernize i
          i:=i - 1;
        end;

        //After dividing, take out the next digit (if ToPosEl>1)
        if (ToPosEl > 1) then
          ToPosEl:= ToPosEl - 1;

        //Initialize the variables
        CurrElInQuotient:= CurrElInQuotient+1;
        ResDiv:=0;
        FoundLarger:= False;
        i:=CurrPosEl;
        j:= Len2;

        //Compare two numbers: the highlighted part of the numerator and denominator
        while (i>=ToPosEl) and (FoundLarger = False) do
        begin

          //Checking conditions for division (the highlighted part of the numerator >= denominator)
          if (((CurrPosEl-ToPosEl+1)=Len2) and (Num1[i]>Num2[j])) or ((CurrPosEl-ToPosEl+1)>Len2)
          or ((j = 1) and (Num1[i]=Num2[j])) then
          begin

            //Initialize the variables
            CarryRes:=0;
            k:= 1;
            p:= ToPosEl;

            //Cycle to subtract two numbers: the highlighted part of the numerator and denominator
            while p<=CurrPosEl do
            begin

              //Considering the signs, starting to subtract the last digits of the numbers (in the mirrored view it is first)
              //and consider the carry (if there is).
              Res:= Num1[p] - Num2[k] + CarryRes;

              //If the difference is less than zero, then we take 1 (for the current digit it is NS) from the next digit
              if Res < 0 then
              begin
                Res:= Res + NS;
                CarryRes:= -1;
              end
              //Else carry = 0
              else
                CarryRes:= 0;

              //Put the result in the residual array c
              Num1[p]:= Res;

              //Modernize variables
              k:= k + 1;
              p:= p + 1;

            end;

            //Since the highlighted part of the numerator was taken away from the denominator once, perform +1
            ResDiv:= ResDiv + 1;

            //Checking for deletion of digits
            if (Num1[CurrPosEl] = 0) and (CurrPosEl > 1) then
            begin

              //Correct CurrPosEl
              CurrPosEl:= CurrPosEl - 1;

              //Reset i to initial value (considering changes CurrPosEl)
              i:= CurrPosEl + 1;
            end
            else
              //Reset i to initial value
              i:= CurrPosEl + 1;

            //Reset j to initial value
            j:= len2 + 1;
          end

          //Otherwise check the condition - the highlighted part of the numerator < denominator
          else if ((CurrPosEl-ToPosEl+1)<Len2) or (((CurrPosEl-ToPosEl+1)=Len2) and (Num1[i]<Num2[j])) then
          begin

            //Exiting the cycle to consider the next highlighted part of the numerator
            FoundLarger:= True;

            //Check the condition for exiting the main cycle - the final highlighted part of the numerator < the second number
            if (CurrPosEl<Len2) or ((CurrPosEl=Len2) and (Num1[i]<Num2[j])) then
              RemLessDiv:= True;

          end;

          //Modernize variables
          i:= i - 1;
          j:= j - 1;
        end;

        //Write the result of the current element in quotient
        Results[CurrElInQuotient]:= ResDiv;

      until RemLessDiv = True;



      Writeln('The prod of the numbers is:');

      //If the first highlighted part of the numerator was < denominator, then zero is not taken out - correct it (if there is)
      if Results[1] = 0 then
        i:= 2
      else
        i:= 1;

      //�ount for final element in quotient (�onsidering division method)
      CurrElInQuotient:= CurrElInQuotient + ToPosEl - 1;

      //Write the answer, mirroring the back
      //And transfer to symbolic value (+1 because numbering in delphi starts from 1)
      while i<=CurrElInQuotient do
      begin
        Write(NSAlphabet[Results[i]+1]);
        i:= i + 1;
      end;

      Writeln;
      Writeln('Remainder after division is:');

      //Write the remainder after division, deleting unnecessary zeros
      DelZero:= False;
      for i := CurrPosEl downto 1 do
      begin
        if (DelZero = False) and (Num1[i] > 0) then
          DelZero:= True;
        if (DelZero = True) or (i = 1) then
          Write(NSAlphabet[Num1[i]+1]);
      end;

    end;

  end;

  Readln;
End.
