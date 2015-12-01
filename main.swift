//
//  main.swift
//  BigNum

import Foundation


//separates last 17 characters from the rest of the string
func cutString(x:String) -> (String, String)
{
   var stringOne = ""
   var stringTwo = x
   var length = count(x)
   var counter = 0
   if(length>17)
   {
      while(counter<17)
      {
         stringOne = "\(String(stringTwo.removeAtIndex(stringTwo.endIndex.predecessor())))\(stringOne)"
         counter++
      }
      return (stringTwo, stringOne)
   }
   else
   {
      return (stringTwo, "0")
   }
}


class BigNum
{
   var data_string:String
   var list:BigNumNode
   
   init(data_entered_as_string:String)
   {
      data_string = data_entered_as_string
      list = BigNumNode(data_String: data_entered_as_string)
   }
   
   func getList() -> BigNumNode
   {
      return list
   }
   //returns value of subtracting param from caller. param and caller remain the same.
   func subtractBigNum(BigNumVar:BigNum) -> BigNum
   {
      if(count(BigNumVar.data_string) > count(self.data_string)) //produces negative value.
      {
         println("Performing action would create negative number. Cannot do this.")
         return BigNum(data_entered_as_string: self.data_string)
      }
      else if(count(BigNumVar.data_string) == count(self.data_string))
      {
         
         var big_num = BigNum(data_entered_as_string: self.data_string)
         var self_list = big_num.getList()
         
         if(BigNumVar.data_string == self.data_string) //equal value. produces 0.
         {
            return BigNum(data_entered_as_string: "0")
         }
         
         
         var sub_list = BigNumVar.getList()
         var can_subtract = false
         
         while(self_list.first != true) //loop checks to see if caller is greater than parameter.
         {
            if(self_list.data.toInt()! < sub_list.data.toInt()!)
            {
               can_subtract = false
            }
            else if(self_list.data.toInt()! > sub_list.data.toInt()!)
            {
               can_subtract = true
            }
            
            self_list = self_list.previous!
            sub_list = sub_list.previous!
            
         }
         //go through for last section
         if(self_list.data.toInt()! < sub_list.data.toInt()!)
         {
            can_subtract = false
         }
         else if(self_list.data.toInt()! > sub_list.data.toInt()!)
         {
            can_subtract = true
         }
         
         if(can_subtract == false) //caller is less than parameter
         {
            println("Performing action would create negative number. Cannot do this.")
            return BigNum(data_entered_as_string: self.data_string)
         }//otherwise, can_subtract is true
         
         self_list = big_num.getList()
         sub_list = BigNumVar.getList() //at beginning of lists.
         
         var num = 0
         var previousNode = 0
         
         while(self_list.first != true) //loop performs subtraction.
         {
            num = self_list.data.toInt()! - sub_list.data.toInt()!
            
            if(num < 0)
            {
               previousNode = self_list.previous!.data.toInt()!-1
               self_list.previous!.data = "\(previousNode)"
               num+=100000000000000000 //18 digits
               
               var zeros = ""
               var amount = count("\(num)") //have number of zeros to go in front
               amount = 17-amount
               for(var i = 0; i < amount; i++)
               {
                  zeros+="\(0)"
               }
               self_list.data = zeros+"\(num)"
            }
            else
            {
               var zeros = ""
               var amount = count("\(num)") //have number of zeros to go in front
               amount = 17-amount
               for(var i = 0; i < amount; i++)
               {
                  zeros+="\(0)"
               }
               self_list.data = zeros+"\(num)"
            }
            
            self_list = self_list.previous!
            sub_list = sub_list.previous!
         }
         //at end of loop. self_list is at the last node, which stores the first set of numbers
         
         num = self_list.data.toInt()! - sub_list.data.toInt()!
         
         self_list.data = "\(num)"
         
         while(self_list.last != true && self_list.data.toInt()! == 0)
         {
            self_list = self_list.next!
            self_list.previous = nil
         }
         
         self_list.first = true
         
         var data_as_string = ""
         
         while(self_list.next != nil)
         {
            data_as_string+=self_list.data
            self_list = self_list.next!
         }
         
         data_as_string+=self_list.data //store last segment
         
         while(data_as_string[data_as_string.startIndex] == "0")
         {
            data_as_string.removeAtIndex(data_as_string.startIndex)
         }
         
         return BigNum(data_entered_as_string: data_as_string)
      }
      else //caller is definitely larger (its count is larger)
      {
         var big_num = BigNum(data_entered_as_string: self.data_string)
         var self_list = big_num.getList()
         var sub_list = BigNumVar.getList() //start at beginning (with last 17 digits)
         
         var num = 0
         var previousNode = 0
         
         while(sub_list.first != true) //loop performs subtraction.
         {
            num = self_list.data.toInt()! - sub_list.data.toInt()!
            
            if(num < 0)
            {
               previousNode = self_list.previous!.data.toInt()!-1
               self_list.previous!.data = "\(previousNode)"
               num+=100000000000000000 //18 digits
               
               var zeros = ""
               var amount = count("\(num)") //have number of zeros to go in front
               amount = 17-amount
               for(var i = 0; i < amount; i++)
               {
                  zeros+="\(0)"
               }
               self_list.data = zeros+"\(num)"
            }
            else
            {
               var zeros = ""
               var amount = count("\(num)") //have number of zeros to go in front
               amount = 17-amount
               for(var i = 0; i < amount; i++)
               {
                  zeros+="\(0)"
               }
               self_list.data = zeros+"\(num)"
            }
            
            self_list = self_list.previous!
            sub_list = sub_list.previous!
         }
         
         num = self_list.data.toInt()! - sub_list.data.toInt()!
         
         self_list.data = "\(num)" //at front of list
         
         while(self_list.last != true && self_list.data.toInt() == 0)
         {
            self_list = self_list.next!
            self_list.previous = nil
         }
         
         self_list.first = true
         
         var data_as_string = ""
         
         while(self_list.next != nil)
         {
            data_as_string+=self_list.data
            self_list = self_list.next!
         }
         
         
         
         data_as_string+=self_list.data //store last segment
         
         while(data_as_string[data_as_string.startIndex] == "0")
         {
            data_as_string.removeAtIndex(data_as_string.startIndex)
         }
         
         return BigNum(data_entered_as_string: data_as_string)
         
      }
   }
   
   //returns value of adding param and caller. param and caller remain the same.
   func addBigNum(BigNumVar:BigNum) -> BigNum
   {
      
      var num = 0
      
      if(count(self.data_string) >= count(BigNumVar.data_string))
      {
         var big_num = BigNum(data_entered_as_string: self.data_string)
         var self_list = big_num.getList()
         var add_list = BigNumVar.getList()
         
         while(add_list.first != true)
         {
            num = add_list.data.toInt()! + self_list.data.toInt()!
            self_list.data = "\(num)"
            if(count(self_list.data) > 17)
            {
               self_list.data.removeAtIndex(self_list.data.startIndex)
               self_list.previous!.data = "\(self_list.previous!.data.toInt()!+1)"
            }
            self_list = self_list.previous!
            add_list = add_list.previous!
         }
         
         num = add_list.data.toInt()! + self_list.data.toInt()!
         self_list.data = "\(num)"
         
         while(count(self_list.data) > 17 && self_list.first != true) //go through and make each node only contain 17 digits
         {
            self_list.data.removeAtIndex(self_list.data.startIndex)
            self_list.previous!.data = "\(self_list.previous!.data.toInt()!+1)"
            self_list = self_list.previous!
         }
         
         if(self_list.first == true && count(self_list.data) > 17) //if at beginning and >17, make a new node
         {
            self_list.previous = BigNumNode(data_String: "1")
            self_list.previous!.last = false
            self_list.previous!.first = true
            self_list.first = false
            self_list = self_list.previous! //at beginning
         }
         
         while(self_list.first != true)
         {
            self_list = self_list.previous!
         }
         
         var data_as_string = ""
         while(self_list.next != nil)
         {
            data_as_string+=self_list.data
            self_list = self_list.next!
         }
         
         data_as_string+=self_list.data
         
         return BigNum(data_entered_as_string: data_as_string)
      }
      else
      {
         var big_num = BigNum(data_entered_as_string: BigNumVar.data_string)
         var self_list = big_num.getList()
         var add_list = self.getList()
         
         while(add_list.first != true)
         {
            num = add_list.data.toInt()! + self_list.data.toInt()!
            self_list.data = "\(num)"
            if(count(self_list.data) > 17)
            {
               self_list.data.removeAtIndex(self_list.data.startIndex)
               self_list.previous!.data = "\(self_list.previous!.data.toInt()!+1)"
            }
            self_list = self_list.previous!
            add_list = add_list.previous!
         }
         
         num = add_list.data.toInt()! + self_list.data.toInt()!
         self_list.data = "\(num)"
         
         while(count(self_list.data) > 17 && self_list.first != true) //go through and make each node only contain 17 digits
         {
            self_list.data.removeAtIndex(self_list.data.startIndex)
            self_list.previous!.data = "\(self_list.previous!.data.toInt()!+1)"
            self_list = self_list.previous!
         }
         
         if(self_list.first == true && count(self_list.data) > 17) //if at beginning and >17, make a new node
         {
            self_list.previous = BigNumNode(data_String: "1")
            self_list.previous!.last = false
            self_list.previous!.first = true
            self_list.first = false
            self_list = self_list.previous! //at beginning
         }
         
         while(self_list.first != true)
         {
            self_list = self_list.previous!
         }
         
         var data_as_string = ""
         while(self_list.next != nil)
         {
            data_as_string+=self_list.data
            self_list = self_list.next!
         }
         
         data_as_string+=self_list.data
         
         return BigNum(data_entered_as_string: data_as_string)
         
      }
      
   }
   
}


//segments.
class BigNumNode
{
   var data:String
   var first:Bool //in terms of number position (so last node has first as true)
   var last:Bool //in terms of number position
   var previous:BigNumNode? //goes closer to beginning of number
   var next:BigNumNode? //goes backward down the line (reverse-segmented)
   
   
   init(data_String:String)
   {
      
      if(count(data_String) > 17) //not the last node
      {
         var data_hold = cutString(data_String)
         first = false //we know that it cannot be beginning of number (>17)
         last = true
         data = data_hold.1
         previous = BigNumNode(data_String: data_hold.0)
         previous!.next = self //store self as the previous node's next
         
         if let next_var = next
         {
            last = true //there is a next node
         }
         else
         {
            last = false //there is not a next node
         }
         
      }
      else //the last node
      {
         data = data_String
         first = true //we know that this is the last node
         //previous is nil
         last = false
      }

   }
   
}




var big_a = BigNum(data_entered_as_string: "74598132758429378917235894743214312412432141243128734597345793259023457890243578904235897043587942359780452987045278094523807942358709425380792435807956438790536487945326798453269743526784253894537982435978024358970243789024357890245387903443527023450798234578092345789032450978234")
println("Printing big_a data:")
println(big_a.data_string)
var big_b = BigNum(data_entered_as_string: "63584937324819743829574289354325879453278905478923789504239078527938054378290543789025789474321895740325904372950427393712490127943729120337812907543289543789402890432578093245049325879342507892344023857953428975432078942308794352097845320879423587923457890237584920378542903578439")
println("Printing big_b data:")
println(big_b.data_string)
println("Printing result of adding big_b and big_a together:")
var big_c = big_a.addBigNum(big_b)
println(big_c.data_string)

println()
var big_d = BigNum(data_entered_as_string: "574382952437958367924387594327954273985479238795473829753927213478643217846129864721389132469781326973467932169432679673425679845236789235469876312471398235234158542387696354886595346000405329324599341201328431818543828391043312843257842356427836124843621841367848538742538971432934219715437923492137438164329165")
println("Printing big_d data:")
println(big_d.data_string)
var big_e = BigNum(data_entered_as_string: "573247319843754239572791328613429321467893412698134296875423708954230972540728450107031724789361246791423967813679832467589543678961342571243567813426873478943278456978123888417823546889199199254987254364879327985462982340230619382476893146791567854329769845267983567892435768912436814236897132504236873272273343")
println("Printing big_e data:")
println(big_e.data_string)
println("Printing result of subtracting big_e from big_d:")
var big_f = big_d.subtractBigNum(big_e)
println(big_f.data_string)



