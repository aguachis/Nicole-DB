export interface Company {
  companyId: string;
  identification: string;
  tradeName: string | null;
  businessName: string;
  email: string | null;
  isAccountingRequired: boolean;
  specialTaxpayer: string | null;
  status: string;
  representativeId: string | null;
  parentCompanyId: string | null;
  taxpayerType: string | null;
  artisanQualification: string | null;
  environment: string | null;
  currency: string | null;
  timezone: string | null;
  languageCode: string | null;
  createdBy: string;
  createdAt: string;
  updatedBy: string | null;
  updatedAt: string | null;
}
