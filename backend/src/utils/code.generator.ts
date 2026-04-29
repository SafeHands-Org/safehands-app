import crypto from 'crypto';

export const generateCode = (length: number = 6) => {
  const SAFE_CHARS = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
  const bytes = crypto.randomBytes(length);

  return Array.from(bytes, byte =>
    SAFE_CHARS[byte % SAFE_CHARS.length]
  ).join('');
};