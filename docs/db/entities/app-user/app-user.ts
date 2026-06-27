export interface AppUser {
  userId: string;
  personId: string;
  username: string | null;
  passwordHash: string;
  email: string;
  isBlocked: boolean;
  requiresNewPassword: boolean;
  mustUpdate: boolean;
  status: string;
  createdBy: string;
  createdAt: string;
  updatedBy: string | null;
  updatedAt: string | null;
}
