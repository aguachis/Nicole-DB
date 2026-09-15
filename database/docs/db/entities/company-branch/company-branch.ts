export interface CompanyBranch {
  companyBranchId: string;
  companyId: string;
  establishmentCode: string;
  branchName: string | null;
  address: string | null;
  phone: string | null;
  email: string | null;
  city: number | null;
  province: string | null;
  status: string;
  createdBy: string;
  createdAt: string;
  updatedBy: string | null;
  updatedAt: string | null;
}
