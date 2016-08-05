//
//  main.swift
//  BigNum
//
//  Created by Joseph Austin on 11/18/15.
//  Copyright (c) 2015 Joseph Austin. All rights reserved.
//
//  Allows for addition, subtraction, and multiplication of virtually infinitely-sized integers.
//  For use with whole numbers. Examples are at the bottom.

import Foundation


class BigNum
{
   var data_string:String
   
   init(data_entered_as_string:String)
   {
      data_string = data_entered_as_string
   }
   
   func addBigNum(x:BigNum) -> BigNum
   {
      var callerRev = String(self.data_string.characters.reverse())
      var paramRev = String(x.data_string.characters.reverse())
      var equal_size = false
      var count = 0
      var caller_bigger = false
      var mainString = ""

      if callerRev.characters.count < paramRev.characters.count
      {
         count = callerRev.characters.count
      }
      else if callerRev.characters.count == paramRev.characters.count
      {
         count = callerRev.characters.count
         equal_size = true
      }
      else
      {
         count = paramRev.characters.count
         caller_bigger = true
      }
      var add_one = false
      while(count != 0)
      {
         let calVal = Int(String(callerRev.removeAtIndex(callerRev.startIndex)))
         let parVal = Int(String(paramRev.removeAtIndex(paramRev.startIndex)))
         var add = String(calVal!+parVal!)
         if add_one
         {
            add = String((Int(add)!+1))
            add_one = false
         }
         if add.characters.count > 1
         {
            add.removeAtIndex(add.startIndex)
            add_one = true
         }
         
         mainString += add
         count -= 1
      }
      
      if equal_size
      {
         if add_one
         {
            mainString += "1"
         }
         return BigNum(data_entered_as_string: String(mainString.characters.reverse()))
      }
      else if caller_bigger
      {
         while(add_one)
         {
            
            if callerRev.characters.count == 0
            {
               mainString += "1"
               add_one = false
               break
            }
            
            let calVal = Int(String(callerRev.removeAtIndex(callerRev.startIndex)))
            
            var add = String(calVal!+1)
            if add.characters.count > 1
            {
               add.removeAtIndex(add.startIndex)
               mainString += add
            }
            else
            {
               mainString += add
               add_one = false
            }
         }
         mainString += callerRev
         return BigNum(data_entered_as_string: String(mainString.characters.reverse()))
      }
      else
      {
         while(add_one)
         {
            if paramRev.characters.count == 0
            {
               mainString += "1"
               add_one = false
               break
            }
            
            let parVal = Int(String(paramRev.removeAtIndex(paramRev.startIndex)))
            
            var add = String(parVal!+1)
            if add.characters.count > 1
            {
               add.removeAtIndex(add.startIndex)
               mainString += add
            }
            else
            {
               mainString += add
               add_one = false
            }
         }
         mainString += paramRev
         return BigNum(data_entered_as_string: String(mainString.characters.reverse()))
      }
   }
   
   func subBigNum(x:BigNum) -> BigNum
   {
      var mainString = ""
      if self.data_string.characters.count > x.data_string.characters.count
      {
         print("Would produce a negative value.\nReturning BigNum(\"0\")")
         return BigNum(data_entered_as_string: "0")
      }
      else if self.data_string.characters.count == x.data_string.characters.count
      {
         
         while(true)
         {
            var calVal = Int(String(self.data_string.removeAtIndex(self.data_string.startIndex)))
            let parVal = Int(String(x.data_string.removeAtIndex(x.data_string.startIndex)))
            
            if calVal > parVal
            {
               calVal! -= parVal!
               mainString += String(calVal!)
               break
            }
            else if calVal < parVal
            {
               print("Would produce a negative value.\nReturning BigNum(\"0\")")
               return BigNum(data_entered_as_string: "0")
            }
            else {continue}
         }
         
         
      }
      
      var callerRev = String(self.data_string.characters.reverse())
      var paramRev = String(x.data_string.characters.reverse())
      
      
      
      var sub_one = false
      var count = paramRev.characters.count
      print(count)
      while(count > 0)
      {
         var calVal = Int(String(callerRev.removeAtIndex(callerRev.startIndex)))
         let parVal = Int(String(paramRev.removeAtIndex(paramRev.startIndex)))
         
         if sub_one
         {
            calVal! -= 1
            sub_one = false
         }
         
         if parVal > calVal
         {
            sub_one = true
            calVal! += 10
         }

         calVal! -= parVal!
         mainString += String(calVal!)
         count -= 1
      }
      while(sub_one)
      {
         var calVal = Int(String(callerRev.removeAtIndex(callerRev.startIndex)))
         if calVal > 0
         {
            calVal! -= 1
            mainString += String(calVal!)
            sub_one = false
         }
         else
         {
            calVal! = 9
            mainString += String(calVal!)
         }
      }

      mainString += callerRev
      return BigNum(data_entered_as_string: String(mainString.characters.reverse()))
   }
   
   
   
   func multBigNum(x:BigNum) -> BigNum
   {
      var stringVal = "0"
      var xBigNumString = x.data_string
      
      if xBigNumString.characters.first == "0"
      {
         return BigNum(data_entered_as_string: "0")
      }
      
      var selfWorkingLength = self.data_string.characters.count-1
      var xWorkingLength = xBigNumString.characters.count-1
      func multBigNumHelper(workingLength:Int) -> BigNum
      {

         let multVar = xBigNumString.removeAtIndex(xBigNumString.endIndex.predecessor())
         var workingLength = selfWorkingLength
         xWorkingLength -= 1
         selfWorkingLength += 1

         
         var bigNum = BigNum(data_entered_as_string: stringVal)
         
         for char in self.data_string.characters
         {
            var multVal = String(Int(String(multVar))!*Int(String(char))!)

            for _ in 0..<workingLength
            {
               multVal += "0"
            }
            workingLength -= 1

            bigNum = bigNum.addBigNum(BigNum(data_entered_as_string: multVal))
            
         }
         stringVal = bigNum.data_string

         if xWorkingLength < 0
         {
            return BigNum(data_entered_as_string: stringVal)
         }
         else
         {
            return multBigNumHelper(workingLength)
         }
      }
      return multBigNumHelper(xWorkingLength)
   }
   
}






var mult_y = BigNum(data_entered_as_string: "12345678543212345673432532253224321433124435145342351433412231412341452344325423542512443123213")
var mult_x = BigNum(data_entered_as_string: "45678912367483219854654454223478543278345279824578312978437821347841238712478942317812349784537")
print("Multiply answer: ")
var answer = mult_y.multBigNum(mult_x)

print(answer.data_string)
print("MULTIPLY ANSWER ^^^")

var big_a = BigNum(data_entered_as_string: "74598132758429378917235894743214312412432141243128734597345793259023457890243578904235897043587942359780452987045278094523807942358709425380792435807956438790536487945326798453269743526784253894537982435978024358970243789024357890245387903443527023450798234578092345789032450978234")
print("Printing big_a data:")
print(big_a.data_string)
var big_b = BigNum(data_entered_as_string: "63584937324819743829574289354325879453278905478923789504239078527938054378290543789025789474321895740325904372950427393712490127943729120337812907543289543789402890432578093245049325879342507892344023857953428975432078942308794352097845320879423587923457890237584920378542903578439")
print("Printing big_b data:")
print(big_b.data_string)
print("Printing result of adding big_b and big_a together:")
var big_c = big_a.addBigNum(big_b)
print(big_c.data_string)

print("")

var big_d = BigNum(data_entered_as_string: "57438295243795836792438759432795427398547923879547382975392721347864321784612986472138913246978132697346793216943267967342567984523678923546987631247139823523415854238769635488659534600040532932459934120132843181854382839104331284325784235642783612484362184136784853874253897143293421971543792349213743816432916545732895472893068753490243567819652739875690482780945732980")
print("Printing big_d data:")
print(big_d.data_string)
var big_e = BigNum(data_entered_as_string: "57324731984375423957279132861342932146789341269813429687542370895423097254072845010703172478936124679142396781367983246758954367896134257124356781342687347894327845697812388841782354688919919925498725436487932798546298234023061938247689314679156785432976984526798356789243576891243681423689713250423687327227334354783209657439804573280957290759831075892045789420387594320")
print("Printing big_e data:")
print(big_e.data_string)
print("Printing result of subtracting big_e from big_d:")
var big_f = big_d.subBigNum(big_e)
print(big_f.data_string)


