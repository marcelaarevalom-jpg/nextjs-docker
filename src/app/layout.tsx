import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Next.js en Docker",
  description: "Aplicación Next.js contenerizada con Docker (multi-stage build)",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="es" className="h-full antialiased">
      <body className="min-h-full flex flex-col">{children}</body>
    </html>
  );
}
