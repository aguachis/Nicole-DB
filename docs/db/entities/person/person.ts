export interface Person {
  personId: string;
  identificationType: string;
  identification: string;
  personType: string;
  lastName: string | null;
  middleName: string | null;
  firstName: string | null;
  businessName: string | null;
  gender: string | null;
  birthDate: string | null;
  address: string | null;
  phone: string | null;
  email: string | null;
  province: string | null;
  city: number | null;
  remarks: string | null;
  status: string;
  createdBy: string;
  createdAt: string;
  updatedBy: string | null;
  updatedAt: string | null;
}
