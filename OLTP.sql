Create database KhoDL;
     use KhoDL;

     CREATE TABLE hospital
     (
       Facility_ID int(6) primary key not null, 
       Facility_Name char(70) not null,         
       Health_Service_Area char(15),            
       Hospital_County char(11),                
       Operating_Certificate_Number char(8)     
     );

      CREATE TABLE APR_Info 
     (
         APR_DRG_Code CHAR(3) PRIMARY KEY not null,
         APR_DRG_Description CHAR(89),
         APR_MDC_Code CHAR(2) not null,
         APR_MDC_Description CHAR(200),
         APR_Severity_of_Illness_Code CHAR(1) not null,
         APR_Severity_of_Illness_Description CHAR(8),
         APR_Risk_of_Mortality char(8),
         APR_Medical_Surgical_Description char(14)
     );


      CREATE TABLE Payment_Type
     (
      Payment_Type_ID int primary key not null,
      Payment_Typology char(25),
      Payment_Type_Description char(25)
     );


     CREATE TABLE diagnosis
     (
      CCS_Diagnosis_Code char(3) primary key not null,
      APR_DRG_Code CHAR(3) not null,
      CCS_Diagnosis_Description char(255),
      CCS_Procedure_Code char(3) not null,
      CCS_Procedure_Description char(255),
      foreign key (APR_DRG_Code) references APR_info(APR_DRG_Code)
     );

     CREATE TABLE Patient
     (
      Patient_ID int primary key not null,
      Facility_ID int(6) not null,
      CCS_Diagnosis_Code char(3) not null,
      Type_of_Admission char(15) not null,
      Age_Group char(11) not null,
      Zip_Code char(3) not null,
      Gender char(1) not null,
      Race char(32),
      Ethnicity char(20),
      Length_of_Stay char(5),
      Patient_Disposition char(37) not null,
      Date date,
      foreign key (Facility_ID) references hospital(Facility_ID),
      foreign key (CCS_Diagnosis_Code) references diagnosis(CCS_Diagnosis_Code)
     );

     CREATE TABLE Payment
     (
      Patient_ID int primary key not null,
      Payment_Type_ID int not null,
      Emergency_Department_Indicator char(1) not null,
      Total_Charges float not null,
      Total_Costs float not null,
      foreign key (Payment_Type_ID) references Payment_Type(Payment_Type_ID),
      foreign key (Patient_ID) references Patient(Patient_ID)
     );