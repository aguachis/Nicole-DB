export interface Profile {
  profileId: string;
  companyId: string;
  name: string;
  description: string | null;
  status: string;
  createdBy: string;
  createdAt: string;
  updatedBy: string | null;
  updatedAt: string | null;
}
