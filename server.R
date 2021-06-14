library(shiny)
server <- function(input, output){
  
  #BMI Calculator
  bmi<-reactive(
    input$weight/((input$height/100)^2)
  )
  
  output$Bdisplay<-renderText(
    if(is.na(bmi())!= TRUE & input$calculatebutton>0) {
    sprintf("BMI = %.2f kg/m2",bmi())}
    else {
      return("Enter the variables needed")
    }
  )
  output$Bmeans<-renderText(
    if(is.na(bmi())!= TRUE & input$calculatebutton>0) {
    paste("Category: ",
          if(bmi()<16){
            "Severe Thinness"
          }else if(bmi()>=16 & bmi()<17){
            "Moderate Thinness"
          }else if(bmi()>=17 & bmi()<18.5){
            "Mild Thinness"
          }else if(bmi()>=18.5 & bmi()<25){
            "Normal"
          }else if(bmi()>=25 & bmi()<30){
            "Overweight"
          }else if(bmi()>=30 & bmi()<35){
            "Obese class I"
          }else if(bmi()>=35 & bmi()<40){
            "Obese class II"
          }else if(bmi()>=40){
            "Obese class III"
          }else
            "Undefined"
    )}
  )
  output$IdealW<-renderText(
    if(is.na(bmi())!= TRUE & input$calculatebutton>0) {
    sprintf("Ideal weight range = %.2f kg - %.2f kg",18.5*((input$height/100)^2),25*((input$height/100)^2))}
  )
  #Body Fat Calculator
  fat<-reactive(
    if(input$sex == "m" & input$age>14){
      return(1.2*bmi()+0.23*input$age-16.2)
    }
    else if(input$sex == "m" & input$age<=14){
      return(1.51*bmi()+0.7*input$age-2.2)
    }
    else if(input$sex == "f" & input$age>14){
      return(1.2*bmi()+0.23*input$age-5.4)
    }
    else if(input$sex == "f" & input$age<=14){
      return(1.51*bmi()+0.7*input$age-1.4)
    }
    else
      return("")
  )
  
  output$fatDisp<-renderText(
    if(is.na(bmi())!= TRUE & input$calculatebutton>0) {
    sprintf("Body Fat Percentage = %.2f %%. Your body fat percentage is categorized as %s",fat(),fatCategory())}
  )
  fatCategory<-function(){
    if(input$sex == 'f'){
      if(fat()>=10 & fat()<14)
        return("Essential fat")
      else if(fat()>=14 & fat()<21)
        return("Athletes")
      else if(fat()>=21 & fat()<25)
        return("Fitness")
      else if(fat()>=25 & fat()<32)
        return("Average")
      else if(fat()>=32)
        return("Obese")
    }else if(input$sex == 'm'){
      if(fat()>=2 & fat()<6)
        return("Essential fat")
      else if(fat()>=6 & fat()<13)
        return("Athletes")
      else if(fat()>=14 & fat()<18)
        return("Fitness")
      else if(fat()>=18 & fat()<25)
        return("Average")
      else if(fat()>=25)
        return("Obese")
    }
  }
  
  #Body Calories Calculator
  cal <- reactive(
    if(input$sex == "m"){
      return (13.397*input$weight + 4.799*input$height - 5.677*input$age + 88.362)
    }
    else if (input$sex == "f"){
      return (9.247*input$weight + 3.098*input$height - 4.330*input$age + 447.593)
    }
    else
      return(" ")
  )
  display <- reactive(
    paste(cat())
  )
  output$calories <- renderText(
    if(is.na(bmi())!= TRUE & input$calculatebutton>0) {
    sprintf("Calories per day (Harris-Benedict Equation) = %.2f kcal/day. This provides your recommended calorie intake per day. %s",cal(),planMeal())}
  )
  planMeal<-function(){
    if(cal()<=1200)
      return("You are recommended to take light meals such as Cereals, Salad, Grilled Chiken and others.")
    else if(cal()>1200 & cal()<=1500)
      return("You are recommended to take moderate meals such as Yogurts, Chicken and Vegetable Soup, Steak and others.")
    else
      return("You are recommended to take heavy meals such as Sandwiches, Pasta, Grilled Salmon and others.")
  }
  #Total Body Water
  TBW <- reactive(
    if(input$sex == "m"){
      return (2.447 - 0.09156*input$age + 0.1074*input$height + 0.3362*input$weight)
    }
    else if (input$sex == "f"){
      return (-2.097 + 0.1069*input$height + 0.2466*input$weight)
    }
    else
      return("")
  )
  output$water <- renderText(
    sprintf("Total body water  = %.2f liters",TBW())
  )
  
  #Daily Water Intakes
  take <- reactive(
    ((2/3)*(input$weight*2.20462) + (input$activity*0.4))*29.5735/1000
  )
  output$intake <- renderText(
    sprintf("It is recommended that you drink = %.2f liters of water per day",take())
  )
  output$pageAbout<- renderImage({
    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext = 'Slide1.PNG')
    
    # Return a list containing the filename
    list(src = outfile,
         contentType = 'image/png',
         alt = "This is alternate text")
  }, deleteFile = TRUE)
  
}