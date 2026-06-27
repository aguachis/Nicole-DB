export interface ProfilePermission {
  profilePermissionId: string;
  profileId: string;
  permissionId: string;
  status: string;
  createdBy: string;
  createdAt: string;
  updatedBy: string | null;
  updatedAt: string | null;
}
