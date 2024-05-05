-- Đổ dữ liệu từ OLTP sang OLAP

-- Đổ dữ liệu vào bảng dim_Hospital:
INSERT INTO DimFactKhoDL.dim_Hospital (Permanent_Facility_ID, Facility_Name, Hospital_County, Hospital_Service_Area)
SELECT Facility_ID, Facility_Name, Hospital_County, Health_Service_Area
FROM Hospital;

-- Đổ dữ liệu vào bảng dim_Disposition
INSERT INTO DimFactKhoDL.dim_Disposition (Patient_Disposition)
SELECT DISTINCT Patient_Disposition
FROM Patient;

-- Đổ dữ liệu vào bảng dim_Gender
INSERT INTO DimFactKhoDL.dim_Gender (Gender)
SELECT DISTINCT Gender
FROM Patient;

-- Đổ dữ liệu vào bảng dim_Admission
INSERT INTO DimFactKhoDL.dim_Admission (Type_of_Admission)
SELECT DISTINCT Type_of_Admission
FROM Patient;

-- Đổ dữ liệu vào bảng dim_LengthOfStay
INSERT INTO DimFactKhoDL.dim_LengthOfStay (Length_of_Stay)
SELECT DISTINCT Length_of_Stay
FROM Patient;

-- Đổ dữ liệu vào bảng dim_PaymentType
INSERT INTO DimFactKhoDL.dim_PaymentType (Payment_Type_ID, Payment_Typology)
SELECT Payment_Type_ID, Payment_Typology
FROM Payment_Type;

-- Đổ dữ liệu vào bảng dim_Date
INSERT INTO DimFactKhoDL.dim_Date (Date, Month, Quarter, Year)
SELECT DISTINCT Date, MONTH(Date), QUARTER(Date), YEAR(Date)
FROM Patient;

-- Đổ dữ liệu vào bảng dim_AgeGroup
INSERT INTO DimFactKhoDL.dim_AgeGroup (Age_Group)
SELECT DISTINCT Age_Group
FROM Patient;

-- Đổ dữ liệu vào bảng dim_Diseases
INSERT INTO DimFactKhoDL.dim_Diseases (Disease_Code, Disease_NAME, Disease_GROUP, Disease_GROUP_NAME, Risk_of_Mortality)
SELECT APR_DRG_Code, APR_DRG_Description, APR_MDC_Code, APR_MDC_Description, APR_Risk_of_Mortality
FROM APR_Info;

-- Đổ dữ liệu vào bảng dim_MedicalSurgical
INSERT INTO DimFactKhoDL.dim_MedicalSurgical (Medical_Surgical)
SELECT DISTINCT APR_Medical_Surgical_Description
FROM APR_Info;

-- Đổ dữ liệu vào bảng Fact_QuantityPatients
INSERT INTO DimFactKhoDL.Fact_QuantityPatients (Patient_ID, Permanent_Facility_ID, Disease_Code, Date, Gender, Length_of_Stay, Patient_Disposition, Medical_Surgical, Age_Group, Type_of_Admission)
SELECT p.Patient_ID, p.Facility_ID, d.CCS_Diagnosis_Code, p.Date, p.Gender, p.Length_of_Stay, p.Patient_Disposition, i.APR_Medical_Surgical_Description, p.Age_Group, p.Type_of_Admission
FROM Patient p
JOIN diagnosis d ON p.CCS_Diagnosis_Code = d.CCS_Diagnosis_Code
JOIN APR_Info i ON d.APR_DRG_Code = i.APR_DRG_Code;

-- Đổ dữ liệu vào bảng Fact_Cost
INSERT INTO DimFactKhoDL.Fact_Cost (Patient_ID, Age_Group, Date, Permanent_Facility_ID, Payment_Type_ID, Disease_Code, Medical_Surgical, Total_Charges, Total_Costs)
SELECT p.Patient_ID, p.Age_Group, p.Date, p.Facility_ID, py.Payment_Type_ID, d.CCS_Diagnosis_Code, i.APR_Medical_Surgical_Description, py.Total_Charges, py.Total_Costs
FROM Payment py
JOIN Patient p ON py.Patient_ID = p.Patient_ID
JOIN diagnosis d ON p.CCS_Diagnosis_Code = d.CCS_Diagnosis_Code
JOIN APR_Info i ON d.APR_DRG_Code = i.APR_DRG_Code;
