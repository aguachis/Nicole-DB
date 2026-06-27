export interface CompanyEmissionPoint {
  companyEmissionPointId: string;
  companyBranchId: string;
  emissionPointCode: string;
  name: string | null;
  status: string;
  createdBy: string;
  createdAt: string;
  updatedBy: string | null;
  updatedAt: string | null;
}
