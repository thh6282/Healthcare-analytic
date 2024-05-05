Create database DimFactKhoDL;
USE DimFactKhoDL;

-- Tạo dim

create table dim_Hospital
(Permanent_Facility_ID int(6) primary key not null,   
 Facility_Name char(70) not null,         
 Hospital_County char(11) not null,
 Hospital_Service_Area char(15) not null);

create table dim_Disposition
(Patient_Disposition char(37) primary key not null);    

create table dim_Gender
(Gender char(1) primary key not null);

create table dim_Admission
(Type_of_Admission char(15) primary key not null);

create table dim_LengthOfStay
(Length_of_Stay char(5) primary key not null); 
 
create table dim_PaymentType
(Payment_Type_ID int primary key not null,         
 Payment_Typology char(25) not null);
 
 create table dim_Date
(Date date primary key not null,            
Month int not null,
Quarter int not null,
Year int not null);

create table dim_AgeGroup
(Age_Group char(11) Primary key not null);
  
create table dim_Diseases
(
 Disease_Code CHAR(3) primary key not null,       
 Disease_NAME CHAR(89),
 Disease_GROUP CHAR(2),
 Disease_GROUP_NAME CHAR(200),
 Risk_of_Mortality char(8) not null
);

create table dim_MedicalSurgical
(Medical_Surgical CHAR(14) primary key not null);




         

-- Tạo Fact

create table Fact_QuantityPatients
(Patient_ID int primary key not null,
Permanent_Facility_ID int(6) not null, 
Disease_Code CHAR(3) not null,
Date date not null,
Gender char(1) not null,
Length_of_Stay char(5) not null,
Patient_Disposition char(37) not null,
Medical_Surgical CHAR(14) not null,
Age_Group char(11) not null,
Type_of_Admission char(15) not null,
foreign key (Patient_Disposition) references dim_Disposition(Patient_Disposition),
foreign key (Gender) references dim_Gender(Gender),
foreign key (Type_of_Admission) references dim_Admission(Type_of_Admission),
foreign key (Length_of_Stay) references dim_LengthOfStay(Length_of_Stay),
foreign key (Permanent_Facility_ID) references dim_Hospital(Permanent_Facility_ID),
foreign key (Date) references dim_Date(Date),
foreign key (Age_Group) references dim_AgeGroup(Age_Group),
foreign key (Disease_Code) references dim_Diseases(Disease_Code),
foreign key (Medical_Surgical) references dim_MedicalSurgical(Medical_Surgical)
);



create table Fact_Cost
(Patient_ID int primary key not null,
Age_Group char(11) not null,
Date date not null,
Permanent_Facility_ID int(6) not null,
Payment_Type_ID int not null,  
Disease_Code CHAR(3) not null,
Medical_Surgical CHAR(14) not null,
Total_Charges float not null,
Total_Costs float not null,
foreign key (Permanent_Facility_ID) references dim_Hospital(Permanent_Facility_ID),
foreign key (Payment_Type_ID) references dim_PaymentType(Payment_Type_ID),
foreign key (Disease_Code) references dim_Diseases(Disease_Code),
foreign key (Date) references dim_Date(Date),
foreign key (Age_Group) references dim_AgeGroup(Age_Group),
foreign key (Medical_Surgical) references dim_MedicalSurgical(Medical_Surgical)
);
